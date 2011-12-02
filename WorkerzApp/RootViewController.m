//
//  RootViewController.m
//  WorkerzApp
//
//  Created by jeff on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "IAMWorker.h"
#import "IAMWorkerXMLParser.h"
#import "WorkerDetailViewController.h"
#import "WorkerzAppAppDelegate.h"
#import "Reachability.h"

@class WorkerDetailViewController;


@implementation RootViewController

@synthesize workerz;
@synthesize workerDetailController;
@synthesize segmentedControl;
@synthesize showAll, showMissing;

- (void) getWorkerz {
    //Fill workerz Array
    //self.workerz = [[NSArray alloc] initWithObjects:@"jeff meyers",@"huey lewis", nil];
    
    IAMWorker *jeff = [[IAMWorker alloc] init];
    jeff.userName = @"jeff";
    jeff.firstName = @"Jeff";
    jeff.lastName = @"Meyers";
    jeff.location = @"Staff Office";
    jeff.timeIn = @"8:30 AM";
    jeff.timeOut = @"3:30 PM";
    jeff.workerTypeName = @"Full Time Staff";
    
    IAMWorker *huey = [[IAMWorker alloc] init];
    huey.userName = @"hlewis";
    huey.firstName = @"Huey";
    huey.lastName = @"Lewis";
    huey.location = @"Staff Offices";
    huey.timeIn = @"8:00 AM";
    huey.timeOut = @"4:00 PM";
    huey.workerTypeName = @"Full Time Staff";
    
    //Get image
        
    self.workerz = [[NSMutableArray alloc] init];
    [workerz addObject: jeff];
    [workerz addObject:huey];
    
    [workerz release];
    [jeff release];
    [huey release];

}

- (void) GetData {
    //Read XML
    //Details URL http://iam.colum.edu/services/webServiceworkerz.asmx/GetWorkerDetails?peopleID=1
    //ALL URL http://iam.colum.edu/services/webServiceworkerz.asmx/GetWorkerzAll
    //IN URL http://iam.colum.edu/services/webServiceworkerz.asmx/GetWorkerzInAndOut
    
        
    IAMWorkerXMLParser  * iamParser = [[IAMWorkerXMLParser alloc] init];
    iamParser.showAll = self.showAll;
    iamParser.showMissing = self.showMissing;
    
    NSString * serviceURL = @"http://iam.colum.edu/services/webServiceworkerz.asmx/GetWorkerzInAndOut";
    if(iamParser.showAll)
    {
        serviceURL = @"http://iam.colum.edu/services/webServiceworkerz.asmx/GetWorkerzAll";    
    }
    
    NSURL *URL=[[NSURL alloc] initWithString:serviceURL];
    //Show user that we are making a request
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSData *data = [[NSData alloc] initWithContentsOfURL:URL];
    
    //NSString *results = [[NSString alloc] initWithContentsOfURL :URL];
    NSError *err = [[NSError alloc] init];

    [iamParser parseWorkerData:data parseError:&err];
    if([iamParser.workerz count] == 0)
    {
        [iamParser addNoWorkers];
    }
    self.workerz = iamParser.workerz;
    
    //Show user that request has ended
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [data release];
    [URL release];
    [err release];
    [iamParser release];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"IAM Workerz"];
    [self getWorkerz];
    showAll = NO;
    shoeMissing = NO;
    
    
    
    // check for internet connection
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    
    //internetReachable = [[Reachability reachabilityForInternetConnection] retain];
    //[internetReachable startNotifier];
    
    // check if a pathway to a random host exists
    //hostReachable = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
    //[hostReachable startNotifier];
    
    // now patiently wait for the notification    
    [self GetData];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
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

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //tblInsideUIView = tableView;
    tableView.rowHeight = 120;
    tableView.showsHorizontalScrollIndicator = YES;
    self.tableView = tableView;
    return [self.workerz count];

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    return @"IAM Workerz";
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    //Get worker from array
    IAMWorker *worker = [self.workerz objectAtIndex:[indexPath row]];
    //Append first and last name of worker
    NSString *workerName = [NSString stringWithFormat:@"%@ %@", worker.firstName, worker.lastName];
    workerName = [workerName stringByAppendingFormat:@"\n%@", worker.workerTypeName];
    
    // Configure the cell.
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;	
    
    //cell.imageView.contentMode = UIViewAnimationOptionTransitionCurlDown;
    
    if(worker.userName != @"none")
    {
        CGRect frame;
        frame.size.width=90; frame.size.height=120;
        frame.origin.x=0; frame.origin.y=0;
        
        if(worker.workerImage)
        {
            cell.imageView.image = worker.workerImage;
        }
        else
        {
            //no image yet set deafult image
            UIImage *DefaultImage = [UIImage imageNamed:@"IAMTreatment90x120.png"];
            cell.imageView.clearsContextBeforeDrawing = YES;
            cell.imageView.image = DefaultImage;
            
            AsynchronousImageView* asyncImage = [[[AsynchronousImageView alloc]
                                   initWithFrame:frame] autorelease];
            [asyncImage loadImageFromURLString:[worker getImagePath]];
            asyncImage.tag =  [worker.peopleID intValue];
    
            //cell.imageView.image = asyncImage.image;
            // Again, valid UIView *view:
            for(UIView *subview in [cell.contentView subviews]) {
                if([subview isKindOfClass:[AsynchronousImageView class]]) {
                    [subview removeFromSuperview];
                } else {
                // Do nothing - not a UIButton or subclass instance
                }
            }
            
            [cell.contentView addSubview:asyncImage];
        
        }
        
        
    }
    NSString *subtitle = [NSString stringWithFormat:@"%@\n%@ - %@", 
                          worker.location, worker.timeIn, worker.timeOut];
    if(showAll)
        subtitle = @"";
    
    cell.textLabel.text = workerName;
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.detailTextLabel.text = subtitle;
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    //[mydata release];
    //[myimage release]; 
    //[asyncImage release];
    
    return cell;
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
	*/
    
    //Pass selected object to new view controller
    //Get worker from array
    IAMWorker *worker = [self.workerz objectAtIndex:[indexPath row]]; 
    workerDetailController.title = worker.userName;
    workerDetailController.currentWorker = worker;
    
    [self.navigationController pushViewController:workerDetailController animated:YES];
    workerDetailController.currentWorker = worker;
    
    //[workerDetailController release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    workerz = nil;
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [segmentedControl release];
    [workerz release];
    [super dealloc];
}

-(IBAction) segmentedControlIndexChanged{
    
    switch (self.segmentedControl.selectedSegmentIndex) {
            
        case 0:
            
            //self.segmentLabel.text =@"Segment 1 selected.";
            self.showAll = NO;
            self.showMissing = NO;
            break;
            
        case 1:
            
            //self.segmentLabel.text =@"Segment 2 selected.";
            self.showAll = NO;
            self.showMissing = YES;
            break;
            
            
            
        default:
            self.showAll = YES;
            self.showMissing = NO;
            break;
            
    }
    [self GetData];
    [self.tableView reloadData];
}
@end
