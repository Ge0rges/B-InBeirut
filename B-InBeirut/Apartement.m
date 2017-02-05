//
//  Apartement.m
//  B-InBeirut
//
//  Created by Georges Kanaan on 6/30/14.
//  Copyright (c) 2014 B-In Beirut. All rights reserved.
//

#import "Apartement.h"

@interface Apartement ()
- (NSDictionary *)dictionnaryForApartement;
@end

@implementation Apartement

-(instancetype)initWithDic:(NSDictionary *)apartementDic {
    if (self = [super init]) {
        //populate the properties
        self.buildingName = [apartementDic objectForKey:@"Building Name"];
        self.reference = [apartementDic objectForKey:@"REF"];
        self.bedrooms = [apartementDic objectForKey:@"BED"];
        self.contactPerson = [apartementDic objectForKey:@"Contact Person"];
        self.price = [apartementDic objectForKey:@"Asking Price (USD)"];
        self.sqm =  [apartementDic objectForKey:@"Area in sqm"];
        self.rent_sale = [apartementDic objectForKey:@"Rent / Sale"];
        self.type = [apartementDic objectForKey:@"Type"];
        self.location = [apartementDic objectForKey:@"Location"];
        self.propertyOwner = [apartementDic objectForKey:@"Property Owner"];
        self.agent = [apartementDic objectForKey:@"By Whom"];
        self.floor = [apartementDic objectForKey:@"Floor"];
        self.bathrooms = [apartementDic objectForKey:@"BATH"];
        self.addOn = [apartementDic objectForKey:@"add on"];
        self.parking = [apartementDic objectForKey:@"Parking"];
        self.contactNumber = [apartementDic objectForKey:@"Contact Number"];
        self.keyLocation = [apartementDic objectForKey:@"Key Location"];
        self.comments = [apartementDic objectForKey:@"Comments"];
        self.rented = [apartementDic objectForKey:@"Rented"];
        if (!self.rented) {
            self.rented = @"N/A";
        }
    }
    
    return self;
}

-(BOOL)saveNewApartement {
    //check if the aprt is nil
    if (!self) return NO;
    
    //create the NSDictionnary
    NSDictionary *aprtDic = [self dictionnaryForApartement];
    
    //get the new path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //get the current number of apartements
    int number = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfApartements"];
    NSString *plistPath = [NSString stringWithFormat:@"%@/apartement%i.plist", [[documentsDirectory stringByAppendingPathComponent:@"B-InBeirut"] stringByAppendingPathComponent:@"Apartements"], number+1];
    
    //write the aprtDic to the plist
    BOOL written = [aprtDic writeToFile:plistPath atomically:YES];
    
    if (written) {
        [[NSUserDefaults standardUserDefaults] setInteger:number+1 forKey:@"numberOfApartements"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return written;
}

-(BOOL)saveApartement {
    //get the number of the apartement which matches the reference
    //get the current number of apartements
    int number = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfApartements"];
    
    //get the path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    for (int i = 0; i <= number; i++) {//get each apartement
        NSString *plistPath = [NSString stringWithFormat:@"%@/apartement%i.plist", [[documentsDirectory stringByAppendingPathComponent:@"B-InBeirut"] stringByAppendingPathComponent:@"Apartements"], i];
        NSDictionary *apartementDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        
        if ([[self dictionnaryForApartement] isEqualToDictionary:apartementDic]) {//if the reference matches delete this apartement
            //go through all plists above the one we need to delete and decrement there move number by 1
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString *plistPath = [NSString stringWithFormat:@"%@/apartement%i.plist", [[documentsDirectory stringByAppendingPathComponent:@"B-InBeirut"] stringByAppendingPathComponent:@"Apartements"], i];
            
            BOOL written = [[self dictionnaryForApartement] writeToFile:plistPath atomically:YES];
            
            return written;
        }
    }
    
    return NO;
}

- (BOOL)deleteApartement {
    //get the number of the apartement which matches the reference
    //get the current number of apartements
    int number = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfApartements"];
  
    //get the path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    for (int i = 0; i <= number; i++) {//get each apartement
        NSString *plistPath = [NSString stringWithFormat:@"%@/apartement%i.plist", [[documentsDirectory stringByAppendingPathComponent:@"B-InBeirut"] stringByAppendingPathComponent:@"Apartements"], i];
        NSDictionary *apartementDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];

        if ([[self dictionnaryForApartement] isEqualToDictionary:apartementDic]) {//if the reference matches delete this apartement
            //go through all plists above the one we need to delete and decrement there move number by 1
            for (int a = i; a <= number; a++) {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString *oldPath = [NSString stringWithFormat:@"%@/apartement%i.plist", [[documentsDirectory stringByAppendingPathComponent:@"B-InBeirut"] stringByAppendingPathComponent:@"Apartements"], a];
                NSString *newPath = [NSString stringWithFormat:@"%@/apartement%i.plist", [[documentsDirectory stringByAppendingPathComponent:@"B-InBeirut"] stringByAppendingPathComponent:@"Apartements"], a-1];
                
                NSError *error;
                [[NSFileManager defaultManager] moveItemAtPath:oldPath toPath:newPath error:&error];
                [[NSFileManager defaultManager] removeItemAtPath:oldPath error:&error];
                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/apartement%i.plist", [[documentsDirectory stringByAppendingPathComponent:@"B-InBeirut"] stringByAppendingPathComponent:@"Apartements"], -1] error:&error];//makes sure we don't have a -1 plist

            }

            break;
        }
    }
    
    //synchronise defaults
    [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfApartements"]-1 forKey:@"numberOfApartements"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

- (NSDictionary *)dictionnaryForApartement {
    //get the properties in an array
    if (!_rented) {
        _rented = @" ";
    }
    NSArray *objects = [NSArray arrayWithObjects:_buildingName, _reference, _bedrooms, _contactPerson, _price, _sqm, _rent_sale, _type, _location, _propertyOwner, _agent, _floor, _bathrooms, _addOn, _parking, _contactNumber, _keyLocation, _comments, _rented, nil];
    
    //get the keys in an array
    NSArray *keys = [NSArray arrayWithObjects:@"Building Name", @"REF", @"BED", @"Contact Person", @"Asking Price (USD)", @"Area in sqm", @"Rent / Sale", @"Type", @"Location", @"Property Owner", @"By Whom", @"Floor", @"BATH", @"add on", @"Parking", @"Contact Number", @"Key Location", @"Comments", @"Rented", nil];
    
    //put the keys and objects in an array
    NSDictionary *aprtDic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    //return the dictionnary
    return aprtDic;
}


+(NSArray *)apartements {
    //create a an mutable array to add the objects in
    NSMutableArray *mutableApartements = [NSMutableArray new];
    
    //get the plists
    //get the current number of apartements
    int number = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfApartements"];
    
    //get the path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    for (int i = 0; i <= number; i++) {//get each apartement
        NSString *plistPath = [NSString stringWithFormat:@"%@/apartement%i.plist", [[documentsDirectory stringByAppendingPathComponent:@"B-InBeirut"] stringByAppendingPathComponent:@"Apartements"], i];
        NSDictionary *apartementDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        
        //retrieve each apartement
        Apartement *aprt = [[Apartement alloc] initWithDic:apartementDic];//get the aprt.
        [mutableApartements addObject:aprt];//add the aprt. to the array
    }
    
    return [NSArray arrayWithArray:mutableApartements];
}

@end
