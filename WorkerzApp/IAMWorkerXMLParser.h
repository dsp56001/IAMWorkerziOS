//
//  IAMWorkerXMLParser.h
//  WorkerzApp
//
//  Created by jeff on 7/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAMWorker.h"

@interface IAMWorkerXMLParser : NSObject<NSXMLParserDelegate> {
    NSMutableArray *workerz;
    NSMutableString *currentProperty;
    IAMWorker *currentWorker;
    BOOL showAll;
    BOOL showMissing;
}

@property (nonatomic, retain) NSMutableArray *workerz;

@property (nonatomic, retain) NSMutableString *currentProperty;
@property (nonatomic, retain) IAMWorker *currentWorker;
@property (nonatomic, assign) BOOL showAll;
@property (nonatomic, assign) BOOL showMissing;


- (void)parseWorkerData:(NSData *)data parseError:(NSError **)error;
-(void) addNoWorkers;
@end
