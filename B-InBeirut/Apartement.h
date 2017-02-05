//
//  Apartement.h
//  B-InBeirut
//
//  Created by Georges Kanaan on 6/30/14.
//  Copyright (c) 2014 B-In Beirut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Apartement : NSObject

@property (strong, nonatomic) NSString *buildingName;
@property (strong, nonatomic) NSString *reference;
@property (strong, nonatomic) NSString *bedrooms;
@property (strong, nonatomic) NSString *contactPerson;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *sqm;
@property (strong, nonatomic) NSString *rent_sale;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *propertyOwner;
@property (strong, nonatomic) NSString *agent;
@property (strong, nonatomic) NSString *floor;
@property (strong, nonatomic) NSString *bathrooms;
@property (strong, nonatomic) NSString *addOn;
@property (strong, nonatomic) NSString *parking;
@property (strong, nonatomic) NSString *contactNumber;
@property (strong, nonatomic) NSString *keyLocation;
@property (strong, nonatomic) NSString *comments;
@property (strong, nonatomic) NSString *rented;

-(instancetype)initWithDic:(NSDictionary *)apartementDic;
-(BOOL)saveNewApartement;
-(BOOL)deleteApartement;
-(BOOL)saveApartement;
+(NSArray *)apartements;

@end
