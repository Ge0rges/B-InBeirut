//
//  ViewController.h
//  B-InBeirut
//
//  Created by Georges Kanaan on 6/30/14.
//  Copyright (c) 2014 B-In Beirut. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DataViewController.h"

@class DataViewController;

@interface ViewController : NSViewController {
    BOOL isEditing;
}

@property (strong) IBOutlet NSTextField *nameTF;
@property (strong) IBOutlet NSTextField *refTF;
@property (strong) IBOutlet NSTextField *bedroomTF;
@property (strong) IBOutlet NSTextField *contactPersonTF;
@property (strong) IBOutlet NSTextField *contactNumberTF;
@property (strong) IBOutlet NSTextField *priceTF;
@property (strong) IBOutlet NSTextField *sqmTF;
@property (strong) IBOutlet NSTextField *locationTF;
@property (strong) IBOutlet NSTextField *propertyOwnerTF;
@property (strong) IBOutlet NSTextField *floorTF;
@property (strong) IBOutlet NSTextField *bathroomsTF;
@property (strong) IBOutlet NSTextField *parkingTF;
@property (strong) IBOutlet NSTextField *keyLocationTF;
@property (strong) IBOutlet NSTextField *addOnTF;
@property (strong) IBOutlet NSTextField *commentsTF;

@property (strong) IBOutlet NSSegmentedControl *rent_saleSC;
@property (strong) IBOutlet NSSegmentedControl *typeSC;
@property (strong) IBOutlet NSSegmentedControl *agentSC;
@property (strong) IBOutlet NSSegmentedControl *rentedSC;

@property (strong) IBOutlet NSScrollView *scrollview;

@property (strong) DataViewController *dataVC;
@property (strong) Apartement *aprt;

@end

