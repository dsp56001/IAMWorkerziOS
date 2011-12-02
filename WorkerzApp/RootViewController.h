//
//  RootViewController.h
//  WorkerzApp
//
//  Created by jeff on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IAMWorker.h"
#import "IAMWorkerXMLParser.h"



@class WorkerDetailViewController;
@class WorkerzAppDelegate;
@class IAMWorkerXMLParser;
@class Reachability;

@interface RootViewController : UITableViewController {
    NSMutableArray *workerz;
    WorkerDetailViewController *workerDetailController;
    IBOutlet UISegmentedControl *segmentedControl;
        BOOL showAll;
    BOOL shoeMissing;
    
    Reachability* internetReachable;
    Reachability* hostReachable;
    
}
@property (nonatomic, retain) NSMutableArray *workerz;
@property (nonatomic, retain) IBOutlet WorkerDetailViewController *workerDetailController;
@property (nonatomic,retain) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, assign) BOOL showAll;
@property (nonatomic, assign) BOOL showMissing;
-(IBAction) segmentedControlIndexChanged;
//- (void) checkNetworkStatus:(NSNotification *)notice;
@end
