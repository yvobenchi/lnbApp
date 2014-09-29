//
//  SettingViewController.m
//  lnbApp
//
//  Created by Yves Benchimol on 27/09/2014.
//  Copyright (c) 2014 Yves Benchimol. All rights reserved.
//

#import "SettingViewController.h"
#import "SWRevealViewController.h"
#import "SignInViewController.h"
#import "parse-library-1.4.1/Parse.framework/Headers/Parse.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = NSLocalizedString(@"Setting", nil);
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
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




- (IBAction)logOut:(id)sender {
    [PFUser logOut];
    SignInViewController *signInViewController = [[SignInViewController alloc] init];
    [self presentViewController:signInViewController animated:YES completion:nil];
}
@end
