//
//  WorkerDetailViewController.m
//  WorkerzApp
//
//  Created by jeff on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WorkerDetailViewController.h"
#import "IAMWorkerDetailXMLParser.h"
#import "IAMWorkerDetails.h"
#import "AsynchronousImageView.h"


@implementation WorkerDetailViewController
@synthesize currentWorker;
@synthesize nameLabel, skillsLabel, phoneLabel, emailLabel, positionLabel;
@synthesize monLabel, tuesLabel, wedsLabel, thursLabel, friLabel, satLabel;
@synthesize aImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Get image
    [aImageView loadImageFromURLString:[currentWorker getImagePath]];
    
    
    //Read XML
    //Details URL http://iam.colum.edu/services/webServiceworkerz.asmx/GetWorkerDetails?peopleID=1
    //ALL URL http://iam.colum.edu/services/webServiceworkerz.asmx/GetWorkerzAll
    //IN URL http://iam.colum.edu/services/webServiceworkerz.asmx/GetWorkerzInAndOut
    
    
    IAMWorkerDetailXMLParser  * iamDetailParser = [[IAMWorkerDetailXMLParser alloc] init];
    
    NSLog(@"DetailParse %@ %@ %@", currentWorker.firstName, currentWorker.lastName, currentWorker.peopleID);
    
    NSString * serviceURL = [NSString stringWithFormat:@"http://iam.colum.edu/services/webServiceworkerz.asmx/GetWorkerDetails?peopleID=%@", currentWorker.peopleID ] ;   
    
     
    //NSString * serviceURL = @"http://iam.colum.edu/services/webServiceworkerz.asmx/GetWorkerDetails?peopleID=672";
    
    NSURL *URL=[[NSURL alloc] initWithString:serviceURL];
    NSData *data = [[NSData alloc] initWithContentsOfURL:URL];
    //NSString *results = [[NSString alloc] initWithContentsOfURL :URL];
    NSError *err = [[NSError alloc] init];
    
    
    
    [iamDetailParser parseWorkerDetailData:data parseError:&err];
    //set current worker
    //self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", currentWorker.firstName, currentWorker.lastName];
   
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", currentWorker.firstName, currentWorker.lastName];
    self.skillsLabel.text = iamDetailParser.currentWorkerDetails.skills;
    self.phoneLabel.text = iamDetailParser.currentWorkerDetails.phone;
    self.emailLabel.text = iamDetailParser.currentWorkerDetails.email;
    self.positionLabel.text = iamDetailParser.currentWorkerDetails.position;
    self.monLabel.text = iamDetailParser.currentWorkerDetails.mondayHours;
    self.tuesLabel.text = iamDetailParser.currentWorkerDetails.tuesdayHours;
    self.wedsLabel.text = iamDetailParser.currentWorkerDetails.wednesdayHours;
    self.thursLabel.text = iamDetailParser.currentWorkerDetails.thursdayHours;
    self.friLabel.text = iamDetailParser.currentWorkerDetails.fridayHours;
    self.satLabel.text = iamDetailParser.currentWorkerDetails.saturdayHours;
    
    [data release];
    [URL release];
    [err release];
    [iamDetailParser release];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[currentWorker release];
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */
/*
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
*/
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete)
 {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert)
 {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    //currentWorker = nil;
    [aImageView release];
    [super viewDidUnload];
    
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [currentWorker dealloc];
    [aImageView dealloc];
    [super dealloc];
}





@end
