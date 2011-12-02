//
//  AsynchronousImageView.m
//  WorkerzApp
//
//  Created by jeff on 7/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AsynchronousImageView.h"


@implementation AsynchronousImageView


- (void)loadImageFromURLString:(NSString *)theUrlString
{
    //[self.image release];
    //self.image = nil;
    [self setNeedsDisplay];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:theUrlString] 
                                             cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                         timeoutInterval:30.0];
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)theConnection 
    didReceiveData:(NSData *)incrementalData 
{
    if (data == nil)
        data = [[NSMutableData alloc] initWithCapacity:2048];
    
    [data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection 
{
    
    self.image = [UIImage imageWithData:data];
    
    if(self.image == nil)
    {
        self.image = [UIImage imageNamed:@"IAMTreatment90x120.png"];
    }
    [data release], data = nil;
    [connection release], connection = nil;
}

-(UIImage *)getImage
{
    if(self.image)
        return self.image;
    
    return nil;
}
@end
