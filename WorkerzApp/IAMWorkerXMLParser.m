//
//  IAMWorkerXMLParser.m
//  WorkerzApp
//
//  Created by jeff on 7/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IAMWorkerXMLParser.h"
#import "IAMWorker.h"
#import <Foundation/NSXMLParser.h>


@implementation IAMWorkerXMLParser
    @synthesize workerz, currentWorker, currentProperty;
@synthesize showAll, showMissing;

- (void)parseWorkerData:(NSData *)data parseError:(NSError **)err {
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self]; // The parser calls methods in this class
    [parser setShouldProcessNamespaces:NO]; // We don't care about namespaces
    [parser setShouldReportNamespacePrefixes:NO]; //
    [parser setShouldResolveExternalEntities:NO]; // We just want data, no other stuff
    
    
    self.workerz = [[NSMutableArray alloc] init]; // Create our scheduler list
    
    
    
    [parser parse]; // Parse that data..
    
    if (err && [parser parserError]) {
        *err = [parser parserError];
    }
    
    [parser release];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.currentProperty) {
        [currentProperty appendString:string];
    }
}



- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if (qName) {
        elementName = qName;
    }
    
    if (self.currentWorker) { // Are we in a
        // Check for standard nodes
        if ([elementName isEqualToString:@"PunchedIn"] ||
            [elementName isEqualToString:@"PeopleID"] ||
            [elementName isEqualToString:@"FirstName"] || 
            [elementName isEqualToString:@"LastName"] || 
            [elementName isEqualToString:@"UserName"] || 
            [elementName isEqualToString:@"WorkerTypeName"] ||
            [elementName isEqualToString:@"LocationName"] ||
            [elementName isEqualToString:@"LocationID"] ||
            [elementName isEqualToString:@"StartTime"] ||
            [elementName isEqualToString:@"EndTime"] ||
            [elementName isEqualToString:@"StartTimeString"] ||
            [elementName isEqualToString:@"EndTimeString"] ) 
        {
            self.currentProperty = [NSMutableString string];
        }
    } else { // We are outside of everything, so we need a
        // Check for deeper nested node
        if ([elementName isEqualToString:@"WebWorkerz"]) {
            self.currentWorker = [[IAMWorker alloc] init];
            NSLog(@"ArrayOfWebWorkerz found!");
        }
    } 
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if (qName) {
        elementName = qName;
    }
    
    if (self.currentWorker) { // Are we in a
        // Check for standard nodes
        if ([elementName isEqualToString:@"PunchedIn"]) {
            self.currentWorker.punchedIn = self.currentProperty;
        } else if ([elementName isEqualToString:@"PeopleID"]) {
            self.currentWorker.peopleID = self.currentProperty;
        } else if ([elementName isEqualToString:@"FirstName"]) {
            self.currentWorker.firstName = self.currentProperty;
        } else if ([elementName isEqualToString:@"LastName"]) {
            self.currentWorker.lastName = self.currentProperty;
        } else if ([elementName isEqualToString:@"UserName"]) {
            self.currentWorker.userName = self.currentProperty;
        } else if ([elementName isEqualToString:@"WorkerTypeName"]) {
            self.currentWorker.workerTypeName = self.currentProperty;
        } else if ([elementName isEqualToString:@"LocationName"]) {
            self.currentWorker.location = self.currentProperty;
            if(showAll) //don't show time in all mode
                self.currentWorker.location = @"";
        } else if ([elementName isEqualToString:@"LocationID"]) {
            //self.currentWorker.workerTypeName = self.currentProperty;
        } else if ([elementName isEqualToString:@"StartTime"]) {
            //self.currentWorker.workerTypeName = self.currentProperty;
        } else if ([elementName isEqualToString:@"EndTime"]) {
            //self.currentWorker.workerTypeName = self.currentProperty;
        } else if ([elementName isEqualToString:@"StartTimeString"]) {
            self.currentWorker.timeIn = self.currentProperty;
            if(showAll)     //don't show time in all mode
                self.currentWorker.timeIn = @"";
            // Are we at the end?
        } else if ([elementName isEqualToString:@"EndTimeString"]) { 
            // Corrected thanks to Muhammad Ishaq
            self.currentWorker.timeOut = self.currentProperty;
            if(showAll) //don't show time in all mode
                self.currentWorker.timeOut = @"";
            
            if([self.currentWorker.punchedIn isEqualToString:@"true"]) 
            {
                if (self.showMissing == NO) {
                    [workerz addObject:self.currentWorker]; // Add to the result node
                    NSLog(@"added: %@", currentWorker.userName);
                }
            }
            else if(([self.currentWorker.punchedIn isEqualToString:@"false"]) && (self.showMissing == YES))
            {
                [workerz addObject:self.currentWorker]; // Add to the result node
                NSLog(@"added: %@", currentWorker.userName);
            }
            //[workerz addObject:self.currentWorker]; // Add to the result node
            
            self.currentWorker = nil; // Set nil
            
        }
    }
    // We reset the currentProperty, for the next textnodes..
    self.currentProperty = nil;
}

-(void)addNoWorkers
{
    self.currentWorker = [[IAMWorker alloc] init];
    currentWorker.firstName = @"No";
    currentWorker.lastName = @"Workers";
    currentWorker.userName = @"none";
    [workerz addObject:self.currentWorker];
    currentWorker = nil;
}

@end
