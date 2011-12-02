//
//  AsynchronousImageView.h
//  WorkerzApp
//
//  Created by jeff on 7/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//  http://iphone-dev-tips.alterplay.com/2009/10/asynchronous-uiimage.html

#import <Foundation/Foundation.h>
#import "IAMWorker.h"


@interface AsynchronousImageView : UIImageView 
{
    NSURLConnection *connection;
    NSMutableData *data;
    }

- (void)loadImageFromURLString:(NSString *)theUrlString;
- (UIImage *)getImage;

@end
