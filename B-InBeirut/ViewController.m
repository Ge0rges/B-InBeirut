//
//  ViewController.m
//  B-InBeirut
//
//  Created by Georges Kanaan on 6/30/14.
//  Copyright (c) 2014 B-In Beirut. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
                                    
    // Do any additional setup after loading the view.
    //scroll the form to the top
    NSPoint pt = NSMakePoint(0.0, [[self.scrollview documentView] bounds].size.height);
    [[self.scrollview documentView] scrollPoint:pt];

    if (self.aprt) {//if n apartement was passed to us then we are editing
        //set the is editing bool to yes
        isEditing = YES;
        
        //populate the textfields
        self.nameTF.stringValue = self.aprt.buildingName;
        self.refTF.stringValue = self.aprt.reference;
        self.bedroomTF.stringValue = self.aprt.bedrooms;
        self.contactPersonTF.stringValue = self.aprt.contactPerson;
        self.priceTF.stringValue = self.aprt.price;
        self.sqmTF.stringValue = self.aprt.sqm;
        self.locationTF.stringValue = self.aprt.location;
        self.propertyOwnerTF.stringValue = self.aprt.propertyOwner;
        self.floorTF.stringValue = self.aprt.floor;
        self.bathroomsTF.stringValue = self.aprt.bathrooms;
        self.addOnTF.stringValue = self.aprt.addOn;
        self.parkingTF.stringValue = self.aprt.parking;
        self.contactNumberTF.stringValue = self.aprt.contactNumber;
        self.keyLocationTF.stringValue = self.aprt.keyLocation;
        self.commentsTF.stringValue = self.aprt.comments;
        
    }
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
                                    
    // Update the view, if already loaded.
}

- (IBAction)dismissForm:(id)sender {
    //dismiss the form
    [self dismissViewController:self];
    
    //reload the data
    [self.dataVC reloadData];
}


- (IBAction)addApartement:(id)sender {
    
    //create and configrue the apartement
    self.aprt = [[Apartement alloc] init];
    
    //populate the properties
    self.aprt.buildingName = self.nameTF.stringValue;
    self.aprt.reference = self.refTF.stringValue;
    self.aprt.bedrooms = self.bedroomTF.stringValue;
    self.aprt.contactPerson = self.contactPersonTF.stringValue;
    self.aprt.price = self.priceTF.stringValue;
    self.aprt.sqm =  self.sqmTF.stringValue;
    self.aprt.location = self.locationTF.stringValue;
    self.aprt.propertyOwner = self.propertyOwnerTF.stringValue;
    self.aprt.floor = self.floorTF.stringValue;
    self.aprt.bathrooms = self.bathroomsTF.stringValue;
    self.aprt.addOn = self.addOnTF.stringValue;
    self.aprt.parking = self.parkingTF.stringValue;
    self.aprt.contactNumber = self.contactNumberTF.stringValue;
    self.aprt.keyLocation = self.keyLocationTF.stringValue;
    self.aprt.comments = self.commentsTF.stringValue;
    
    //make sure that selected segement is valid
    if ([self.rent_saleSC selectedSegment] < 0) {
        self.aprt.rent_sale = @"N/A";
    } else {
        self.aprt.rent_sale = [self.rent_saleSC labelForSegment:[self.rent_saleSC selectedSegment]];
    }
    
    if ([self.typeSC selectedSegment] < 0) {
        self.aprt.type = @"N/A";
    } else {
        self.aprt.type = [self.typeSC labelForSegment:[self.typeSC selectedSegment]];
    }
    
    if ([self.agentSC selectedSegment] < 0) {
        self.aprt.agent = @"N/A";
    } else {
        self.aprt.agent = [self.agentSC labelForSegment:[self.agentSC selectedSegment]];
    }
    
    if ([self.agentSC selectedSegment] < 0) {
        self.aprt.rented = @"N/A";
    } else {
        self.aprt.rented = [self.agentSC labelForSegment:[self.agentSC selectedSegment]];
    }
    
    //save the apartement if editing and if not save a new apartement
    BOOL saved;
    if (isEditing) {//if editing
        saved = [self.aprt saveApartement];//save the apartement
    } else {
        saved = [self.aprt saveNewApartement];//save this new apartement
    }
    
    if (!saved) {
        NSAlert *alert = [NSAlert alertWithMessageText:@"Error" defaultButton:@"Ok" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Could not save the apartement"];
        [alert runModal];
    }
    
    [self dismissForm:nil];
}

@end
