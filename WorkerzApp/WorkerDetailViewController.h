//
//  WorkerDetailViewController.h
//  WorkerzApp
//
//  Created by jeff on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAMWorker.h"
#import "IAMWorkerDetails.h"
#import "AsynchronousImageView.h"

@class IAMWorker;
@interface WorkerDetailViewController : UIViewController {
        
    IAMWorker *currentWorker;
    UILabel IBOutlet *nameLabel;
    UILabel IBOutlet *skillsLabel;
    UILabel IBOutlet *phoneLabel;
    UILabel IBOutlet *emailLabel;
    UILabel IBOutlet *positionLabel;
    UILabel IBOutlet *monLabel;
    UILabel IBOutlet *tuesLabel;
    UILabel IBOutlet *wedsLabel;
    UILabel IBOutlet *thursLabel;
    UILabel IBOutlet *friLabel;
    UILabel IBOutlet *satLabel;
    IBOutlet AsynchronousImageView *aImageView;
    
}

@property (nonatomic, retain) IAMWorker *currentWorker;
@property (nonatomic, retain) UILabel IBOutlet *nameLabel;
@property (nonatomic, retain) UILabel IBOutlet *skillsLabel;
@property (nonatomic, retain) UILabel IBOutlet *phoneLabel;
@property (nonatomic, retain) UILabel IBOutlet *emailLabel;
@property (nonatomic, retain) UILabel IBOutlet *positionLabel;
@property (nonatomic, retain) UILabel IBOutlet *monLabel;
@property (nonatomic, retain) UILabel IBOutlet *tuesLabel;
@property (nonatomic, retain) UILabel IBOutlet *wedsLabel;
@property (nonatomic, retain) UILabel IBOutlet *thursLabel;
@property (nonatomic, retain) UILabel IBOutlet *friLabel;
@property (nonatomic, retain) UILabel IBOutlet *satLabel;
@property (nonatomic, retain) IBOutlet AsynchronousImageView *aImageView;

@end
