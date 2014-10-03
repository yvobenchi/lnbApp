//
//  utilsLocalisation.m
//  lnbApp
//
//  Created by Yves Benchimol on 02/10/2014.
//  Copyright (c) 2014 Yves Benchimol. All rights reserved.
//

#import "utilsLocalisation.h"

@implementation utilsLocalisation


+ (CGPoint)localtionOfBallWithNumberOfPoints:(NSInteger)numberOfPoints withPoints:(NSArray*)points withDistances:(NSArray*)distances{
    
    //structure of data
    // numberOfPoints N
    // points = [x1, y1, x2, y2, ..., xN, yN]
    // distance =[d1, ..., dN]
    
    CGPoint resultPoint;
    
    
    //construct matrice A
    //matrixA = [2(x1-xN), 2(y1-yN), 2(x2-xN), 2(y2-yN), ..., 2(x(N-1)-xN), 2(y(N-1)-yN)]
    
    double matrixA[2*(numberOfPoints-1)];
    double xN = [points[2*numberOfPoints-2] doubleValue];
    double yN = [points[2*numberOfPoints-1] doubleValue];
    double dN = [distances[numberOfPoints-1] doubleValue];
    
    for (int i = 0; i < 2*numberOfPoints-2; i+=2)
    {
        double xi = [points[i] doubleValue];
        double yi = [points[i+1] doubleValue];
        matrixA[i] = 2*(xi - xN);
        matrixA[i+1] = 2*(yi - yN);
    }
    
    
    
    //construc vector b
    //vectorB= [x1^2 -xN^2 +y1^2-yN^2+dN^2-d1^2, ..., x(N-1)^2 -xN^2 +y(N-1)^2-yN^2+dN^2-d(N-1)^2]
    double vectorB[numberOfPoints];
    for (int i = 0; i < numberOfPoints-1; i++)
    {
        double xi = [points[2*i] doubleValue];
        double yi = [points[2*i+1] doubleValue];
        double di = [distances[i] doubleValue];
        
        vectorB[i] = xi*xi - xN*xN + yi*yi - yN*yN + dN*dN - di*di;
    }
    
    //do the algo
    
    double matrixATranspose[2*(numberOfPoints-1)];
    vDSP_mtransD(matrixA, 1,matrixATranspose, 1, numberOfPoints-1, 2);
    
    double multiply[numberOfPoints];
    vDSP_mmulD(matrixATranspose, 1,matrixA, 1, multiply, 1, 2, 2, numberOfPoints-1);
    
    matrix_invert(2, multiply);
    double final[4];
    vDSP_mmulD(multiply, 1,matrixATranspose, 1, final, 1, 2, numberOfPoints-1, 2);
    
    
    double finalVector[2];
    
    vDSP_mmulD(final, 1,vectorB, 1, finalVector, 1, 2, 1, 2);
    
    NSLog(@"%f",finalVector[0]);
    NSLog(@"%f",finalVector[1]);
    
    return resultPoint;
    
}

int matrix_invert(int N, double *matrix) {
    
    int error=0;
    int *pivot = malloc(N*sizeof(int)); // LAPACK requires MIN(M,N), here M==N, so N will do fine.
    double *workspace = malloc(N*sizeof(double));
    
    /*  LU factorisation */
    dgetrf_(&N, &N, matrix, &N, pivot, &error);
    
    if (error != 0) {
        NSLog(@"Error 1");
        free(pivot);
        free(workspace);
        return error;
    }
    
    /*  matrix inversion */
    dgetri_(&N, matrix, &N, pivot, workspace, &N, &error);
    
    if (error != 0) {
        NSLog(@"Error 2");
        free(pivot);
        free(workspace);
        return error;
    }
    
    free(pivot);
    free(workspace);
    return error;
}


@end
