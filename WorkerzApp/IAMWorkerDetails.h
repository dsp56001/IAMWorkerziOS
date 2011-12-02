//
//  IAMWorkerDetails.h
//  WorkerzApp
//
//  Created by jeff on 7/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IAMWorkerDetails : NSObject {
    NSString * skills;
    NSString * mondayHours;
    NSString * tuesdayHours;
    NSString * wednesdayHours;
    NSString * thursdayHours;
    NSString * fridayHours;
    NSString * saturdayHours;
    NSString * sundayHours;
    NSString * phone;
    NSString * email;
    NSString * position;
}

@property (nonatomic, retain) NSString * skills;
@property (nonatomic, retain) NSString * mondayHours;
@property (nonatomic, retain) NSString * tuesdayHours;
@property (nonatomic, retain) NSString * wednesdayHours;
@property (nonatomic, retain) NSString * thursdayHours;
@property (nonatomic, retain) NSString * fridayHours;
@property (nonatomic, retain) NSString * saturdayHours;
@property (nonatomic, retain) NSString * sundayHours;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * position;

@end
