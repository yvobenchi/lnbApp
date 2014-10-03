//
//  utilsLocalisation.h
//  lnbApp
//
//  Created by Yves Benchimol on 02/10/2014.
//  Copyright (c) 2014 Yves Benchimol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>

@interface utilsLocalisation : NSObject

+ (CGPoint)localtionOfBallWithNumberOfPoints:(NSInteger)numberOfPoints withPoints:(NSArray*)points withDistances:(NSArray*)distances;

@end
