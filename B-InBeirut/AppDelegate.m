//
//  AppDelegate.m
//  B-InBeirut
//
//  Created by Georges Kanaan on 6/30/14.
//  Copyright (c) 2014 B-In Beirut. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    // Override point for customization after application launch.
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isNotInitialLaunch"]) {
        
        //first time the app launches configure variables
        //set the number of moves to 0
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"numberOfApartements"];
        
        //create a directory for our plists and images
        // Fetch path for document directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        //create the directories needed to store info
        [[NSFileManager defaultManager] createDirectoryAtPath:[documentsDirectory stringByAppendingPathComponent:@"B-InBeirut"] withIntermediateDirectories:NO attributes:nil error:nil];
        [[NSFileManager defaultManager] createDirectoryAtPath:[[documentsDirectory stringByAppendingPathComponent:@"B-InBeirut"] stringByAppendingPathComponent:@"Apartements"] withIntermediateDirectories:NO attributes:nil error:nil];
        [[NSFileManager defaultManager] createDirectoryAtPath:[[documentsDirectory stringByAppendingPathComponent:@"B-InBeirut"] stringByAppendingPathComponent:@"ApartementImages"] withIntermediateDirectories:NO attributes:nil error:nil];
        
        //get the existing apartements data and put it into our system
        NSArray *apartementsArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Apartements" ofType:@"plist"]];
        for (NSDictionary *aprtDic in apartementsArray) {
            Apartement *aprt = [[Apartement alloc] initWithDic:aprtDic];
            [aprt saveNewApartement];
        }
        
        //not a first launch anymore
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isNotInitialLaunch"];
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
