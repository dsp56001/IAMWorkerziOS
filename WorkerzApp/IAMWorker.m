//
//  IAMWorker.m
//  WorkerzApp
//
//  Created by jeff on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IAMWorker.h"


@implementation IAMWorker
@synthesize userName, firstName, lastName, location, timeIn,
    timeOut, peopleID, workerTypeName, punchedIn;

@synthesize workerImage;

-(id) init {
    self = [super init];
    return self;
}

-(NSString *)getImagePath
{
    //Get image from URL based on logonName
    NSString *picURL = @"http://iam.colum.edu/myIAM/workerz/picts/";
    picURL = [picURL stringByAppendingString:self.userName];
    picURL = [picURL stringByAppendingString:@".jpg"];
    return picURL;
}


@end
