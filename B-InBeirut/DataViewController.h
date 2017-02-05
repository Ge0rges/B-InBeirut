//
//  DataViewController.h
//  B-InBeirut
//
//  Created by Georges Kanaan on 6/30/14.
//  Copyright (c) 2014 B-In Beirut. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Apartement.h"
#import "ViewController.h"

@interface DataViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
    NSMutableArray *apartements;
    
    NSArray *filteredApartements;
    
    NSPredicate *searchPredicate;
    
    NSString *category;
}

@property (strong) IBOutlet NSTableView *dataTableView;
@property (strong) IBOutlet NSTextField *nameLabel;
@property (strong) IBOutlet NSTextField *refLabel;
@property (strong) IBOutlet NSTextField *bedroomsLabel;
@property (strong) IBOutlet NSTextField *propertyOwnerLabel;
@property (strong) IBOutlet NSTextField *keyLocationLabel;
@property (strong) IBOutlet NSTextField *addOnLabel;
@property (strong) IBOutlet NSTextField *parkingLabel;
@property (strong) IBOutlet NSTextField *commentsLabel;
@property (strong) IBOutlet NSTextField *rent_saleLabel;
@property (strong) IBOutlet NSTextField *typeLabel;
@property (strong) IBOutlet NSTextField *agentLabel;
@property (strong) IBOutlet NSTextField *bathroomsLabel;
@property (strong) IBOutlet NSTextField *contactDetailsLabel;
@property (strong) IBOutlet NSTextField *priceLabel;
@property (strong) IBOutlet NSTextField *sqmLabel;
@property (strong) IBOutlet NSTextField *locationLabel;
@property (strong) IBOutlet NSTextField *floorLabel;
@property (strong) IBOutlet NSScrollView *scrollView;
@property (strong) IBOutlet NSTextField *rentedLabel;
@property (strong) IBOutlet NSSearchField *searchField;

-(void)reloadData;

@end
