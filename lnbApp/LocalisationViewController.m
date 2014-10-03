//
//  LocalisationViewController.m
//  lnbApp
//
//  Created by Yves Benchimol on 27/09/2014.
//  Copyright (c) 2014 Yves Benchimol. All rights reserved.
//

#import "LocalisationViewController.h"
#import "SWRevealViewController.h"
#import "utilsLocalisation.h"


@interface LocalisationViewController ()

@end

@implementation LocalisationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = NSLocalizedString(@"Localisation", nil);
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    NSArray *points = [NSArray arrayWithObjects:[NSNumber numberWithDouble:1],[NSNumber numberWithDouble:0],[NSNumber numberWithDouble:0],[NSNumber numberWithDouble:-3],[NSNumber numberWithDouble:4],[NSNumber numberWithDouble:1], nil];
    NSArray *distances = [NSArray arrayWithObjects:[NSNumber numberWithDouble:1.5],[NSNumber numberWithDouble:3.91],[NSNumber numberWithDouble:1.24], nil];

   [utilsLocalisation localtionOfBallWithNumberOfPoints:3 withPoints:points withDistances:distances];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
