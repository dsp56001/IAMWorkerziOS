//
//  IAMWorkerDetailXMLParser.h
//  WorkerzApp
//
//  Created by jeff on 7/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAMWorkerDetails.h"


@class IAMWorkerDetails;
@interface IAMWorkerDetailXMLParser : NSObject<NSXMLParserDelegate> {
    NSMutableString *currentProperty;
    IAMWorkerDetails *currentWorkerDetails;
}

@property (nonatomic, retain) NSMutableString *currentProperty;
@property (nonatomic, retain) IAMWorkerDetails *currentWorkerDetails;

- (void)parseWorkerDetailData:(NSData *)data parseError:(NSError **)error;

@end
