//
//  IAMWorker.h
//  WorkerzApp
//
//  Created by jeff on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IAMWorker : NSObject {
    NSString * punchedIn;
    NSString * userName;
    NSString * firstName;
    NSString * lastName;
    NSString * location;
    NSString * timeIn;
    NSString * timeOut;
    NSString * peopleID;
    NSString * workerTypeName;
    UIImage *workerImage;
    
    
}
@property (nonatomic, retain) NSString * punchedIn;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * timeIn;
@property (nonatomic, retain) NSString * timeOut;
@property (nonatomic, retain) NSString * peopleID;
@property (nonatomic, retain) NSString * workerTypeName;
@property (nonatomic, retain) UIImage * workerImage;
-(NSString *)getImagePath;
@end
