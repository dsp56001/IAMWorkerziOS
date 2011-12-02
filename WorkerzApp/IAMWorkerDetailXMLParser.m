//
//  IAMWorkerDetailXMLParser.m
//  WorkerzApp
//
//  Created by jeff on 7/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IAMWorkerDetailXMLParser.h"
#import <Foundation/NSXMLParser.h>



@implementation IAMWorkerDetailXMLParser
    @synthesize currentWorkerDetails, currentProperty;

- (void)parseWorkerDetailData:(NSData *)data parseError:(NSError **)err {
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    
    
    
    [parser setDelegate:self]; // The parser calls methods in this class
    [parser setShouldProcessNamespaces:NO]; // don't care about namespaces
    [parser setShouldReportNamespacePrefixes:NO]; //
    [parser setShouldResolveExternalEntities:NO]; // just want data, no other stuff
    
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
    
    if (self.currentWorkerDetails) { // Are we in a
        // Check for standard nodes
        if ([elementName isEqualToString:@"Skills"] ||
            [elementName isEqualToString:@"MondayHours"] ||
            [elementName isEqualToString:@"TuesdayHours"] || 
            [elementName isEqualToString:@"WednesdayHours"] || 
            [elementName isEqualToString:@"ThursdayHours"] || 
            [elementName isEqualToString:@"FridayHours"] ||
            [elementName isEqualToString:@"SaturdayHours"] ||
            [elementName isEqualToString:@"SundayHours"] ||
            [elementName isEqualToString:@"Phone"] ||
            [elementName isEqualToString:@"Email"] ||
            [elementName isEqualToString:@"Position"]
            ) 
        {
            self.currentProperty = [NSMutableString string];
        }
    } else { // We are outside of everything, so we need a
        // Check for deeper nested node
        if ([elementName isEqualToString:@"WorkerDetailDTO"]) {
            self.currentWorkerDetails = [[IAMWorkerDetails alloc] init];
            NSLog(@"Web Detail found!");
        }
    } 
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if (qName) {
        elementName = qName;
    }
    
    if (self.currentWorkerDetails) { // Are we in a
        // Check for standard nodes
        if ([elementName isEqualToString:@"Skills"]) {
            self.currentWorkerDetails.skills = self.currentProperty;
        } else if ([elementName isEqualToString:@"PeopleID"]) {
            //self.currentWorker.userName = self.currentProperty;
        } else if ([elementName isEqualToString:@"MondayHours"]) {
            self.currentWorkerDetails.mondayHours = self.currentProperty;
        } else if ([elementName isEqualToString:@"TuesdayHours"]) {
            self.currentWorkerDetails.tuesdayHours = self.currentProperty;
        } else if ([elementName isEqualToString:@"WednesdayHours"]) {
            self.currentWorkerDetails.wednesdayHours = self.currentProperty;
        } else if ([elementName isEqualToString:@"ThursdayHours"]) {
            self.currentWorkerDetails.thursdayHours = self.currentProperty;
        } else if ([elementName isEqualToString:@"FridayHours"]) {
            self.currentWorkerDetails.fridayHours = self.currentProperty;
        } else if ([elementName isEqualToString:@"SaturdayHours"]) {
            self.currentWorkerDetails.saturdayHours = self.currentProperty;
        } else if ([elementName isEqualToString:@"SundayHours"]) {
            self.currentWorkerDetails.sundayHours = self.currentProperty;
        } else if ([elementName isEqualToString:@"Phone"]) {
            self.currentWorkerDetails.phone = [NSString stringWithFormat:@"tel:%@",  self.currentProperty];
        } else if ([elementName isEqualToString:@"Email"]) {
            self.currentWorkerDetails.email = self.currentProperty;
            // Are we at the end?
        } else if ([elementName isEqualToString:@"Position"]) { 
            // Corrected thanks to Muhammad Ishaq
            self.currentWorkerDetails.position = self.currentProperty;
            
            //self.currentWorkerDetails = nil; // Set nil why?
            
        }
    }
    // reset the currentProperty, for the next textnodes..
    //self.currentProperty = nil;
}

@end
