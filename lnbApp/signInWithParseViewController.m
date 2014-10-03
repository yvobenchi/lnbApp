//
//  signInWithParseViewController.m
//  lnbApp
//
//  Created by Yves Benchimol on 02/10/2014.
//  Copyright (c) 2014 Yves Benchimol. All rights reserved.
//

#import "signInWithParseViewController.h"
#import "SWRevealViewController.h"
#import "CommunityViewController.h"
#import "RearTableViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface signInWithParseViewController ()

@end

@implementation signInWithParseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        
        //set up the SWreveal
        RearTableViewController *rearTableViewController = [[RearTableViewController alloc] init];
        CommunityViewController *communityViewController = [[CommunityViewController alloc] init];
        
        UINavigationController *communityNavigationController = [[UINavigationController alloc] initWithRootViewController:communityViewController];
        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearTableViewController];
        
        //insert them into the revealController
        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:communityNavigationController];
        
        revealController.delegate = self;
        
        [self presentViewController:revealController animated:YES completion:nil];
        
    } else {
        
        //sign in and sign up viewController
        PFLogInViewController *loginViewController = [[PFLogInViewController alloc] init];
        loginViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton | PFLogInFieldsFacebook | PFLogInFieldsSignUpButton;
        
        
        [loginViewController.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-lnb.png"]]];
        [loginViewController.signUpController.signUpView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-lnb.png"]]];
        loginViewController.delegate = self;
        loginViewController.signUpController.delegate = self;
        
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
    
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

#pragma mark - Delegate PFlogin

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
