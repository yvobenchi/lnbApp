//
//  RearTableViewController.m
//  lnbApp
//
//  Created by Yves Benchimol on 27/09/2014.
//  Copyright (c) 2014 Yves Benchimol. All rights reserved.
//

#import "RearTableViewController.h"
#import "MapViewController.h"
#import "StatsViewController.h"
#import "SettingViewController.h"
#import "LocalisationViewController.h"
#import "CommunityViewController.h"
#import "SWRevealViewController.h"

@interface RearTableViewController ()

@end

@implementation RearTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *cellIdentifier = @"cellIdentifier";
    NSInteger row = indexPath.row;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    NSString *text = nil;
    if (row == 0)
    {
        text = @"Map";
    }
    else if (row == 1)
    {
        text = @"Statistics";
    }
    else if (row == 2)
    {
        text = @"Localisation";
    }
    else if (row == 3)
    {
        text = @"Setting";
    }
    else if (row == 4)
    {
        text = @"Community";
    }
    
    cell.textLabel.text = NSLocalizedString( text, nil );
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Navigation logic may go here, for example:
    // Create the next view controller.

    
    // Pass the selected object to the new view controller.
    
    NSInteger row = indexPath.row;
    UIViewController *newFrontController = nil;
    
    if (row == 0)
    {
        MapViewController *mapViewController = [[MapViewController alloc] init];
        newFrontController = [[UINavigationController alloc] initWithRootViewController:mapViewController];
    }
    else if (row == 1)
    {
        StatsViewController *statsViewController = [[StatsViewController alloc] init];
        newFrontController = [[UINavigationController alloc] initWithRootViewController:statsViewController];
    }
    else if (row == 2)
    {
        LocalisationViewController *localisationViewController = [[LocalisationViewController alloc] init];
        newFrontController = [[UINavigationController alloc] initWithRootViewController:localisationViewController];
    }
    else if (row == 3)
    {
        SettingViewController *settingViewController = [[SettingViewController alloc] init];
        newFrontController = [[UINavigationController alloc] initWithRootViewController:settingViewController];
    }
    else if (row == 4)
    {
        CommunityViewController *communityViewController = [[CommunityViewController alloc] init];
        newFrontController = [[UINavigationController alloc] initWithRootViewController:communityViewController];
    }
    
    
    [self.revealViewController pushFrontViewController:newFrontController animated:YES];
    
    
    
    // Push the view controller.
    //[self.navigationController pushViewController:mapViewController animated:YES];
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
