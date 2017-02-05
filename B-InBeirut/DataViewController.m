//
//  DataViewController.m
//  B-InBeirut
//
//  Created by Georges Kanaan on 6/30/14.
//  Copyright (c) 2014 B-In Beirut. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view
    //get the data
    [self reloadData];
    
    //scroll the form to the top
    NSPoint pt = NSMakePoint(0.0, [[self.scrollView documentView] bounds].size.height);
    [[self.scrollView documentView] scrollPoint:pt];
    
    
    //set the search field categories
    NSMenu *cellMenu = [[NSMenu alloc] initWithTitle:@"Search Menu"];
    NSMenuItem *item;
    
    item = [[NSMenuItem alloc] initWithTitle:@"Area" action:@selector(setSearchCategoryFrom:) keyEquivalent:@""];
    [item setTarget:self];
    [item setTag:1];
    [cellMenu insertItem:item atIndex:0];
    
    item = [[NSMenuItem alloc] initWithTitle:@"Reference" action:@selector(setSearchCategoryFrom:) keyEquivalent:@""];
    [item setTarget:self];
    [item setTag:2];
    [cellMenu insertItem:item atIndex:1];
    
    item = [[NSMenuItem alloc] initWithTitle:@"Building Name" action:@selector(setSearchCategoryFrom:) keyEquivalent:@""];
    [item setTarget:self];
    [item setTag:3];
    [cellMenu insertItem:item atIndex:1];
    
    item = [[NSMenuItem alloc] initWithTitle:@"Type" action:@selector(setSearchCategoryFrom:) keyEquivalent:@""];
    [item setTarget:self];
    [item setTag:4];
    [cellMenu insertItem:item atIndex:1];
    
    item = [[NSMenuItem alloc] initWithTitle:@"Location" action:@selector(setSearchCategoryFrom:) keyEquivalent:@""];
    [item setTarget:self];
    [item setTag:5];
    [cellMenu insertItem:item atIndex:1];
    
    item = [[NSMenuItem alloc] initWithTitle:@"Price" action:@selector(setSearchCategoryFrom:) keyEquivalent:@""];
    [item setTarget:self];
    [item setTag:6];
    [cellMenu insertItem:item atIndex:1];
    
    item = [[NSMenuItem alloc] initWithTitle:@"Rent / Sale" action:@selector(setSearchCategoryFrom:) keyEquivalent:@""];
    [item setTarget:self];
    [item setTag:7];
    [cellMenu insertItem:item atIndex:1];
    
    item = [[NSMenuItem alloc] initWithTitle:@"Property Owner" action:@selector(setSearchCategoryFrom:) keyEquivalent:@""];
    [item setTarget:self];
    [item setTag:8];
    [cellMenu insertItem:item atIndex:1];
    
    id searchCell = [self.searchField cell];
    [searchCell setSearchMenuTemplate:cellMenu];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
    [self reloadData];
}

#pragma mark - NSTableView DataSource
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    //Get a new cell and configure it
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];

    //get the apartement
    Apartement *aprt;
    if (filteredApartements) {
         aprt = [filteredApartements objectAtIndex:row];
    } else {
        aprt = [apartements objectAtIndex:row];
    }
    
    //populate the cell
    if (aprt.reference) {
        cellView.textField.stringValue = aprt.reference;
    } else {
        cellView.textField.stringValue = @"No Reference";
    }
    
    //put a button if it is rented and color the text
    if (![aprt.rented isEqualToString:@""]) {
        cellView.textField.textColor = [NSColor redColor];
    } else {
        cellView.textField.textColor = [NSColor blackColor];
    }
    
    return cellView;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    if (filteredApartements) {
        return [filteredApartements count];
    }
    return [apartements count];
}

-(void)reloadData {
    //get the new set of apartements
    apartements = [NSMutableArray arrayWithArray:[Apartement apartements]];
    
    //reload the tableView
    [self.dataTableView reloadData];
    
    //clear the labels
    self.nameLabel.stringValue = @"Building Name:";
    self.refLabel.stringValue = @"Reference:";
    self.bedroomsLabel.stringValue = @"Bedrooms:";
    self.propertyOwnerLabel.stringValue = @"Property Owner:";
    self.keyLocationLabel.stringValue = @"Key Location:";
    self.addOnLabel.stringValue = @"Add on:";
    self.parkingLabel.stringValue = @"Parking:";
    self.commentsLabel.stringValue = @"Comments:";
    self.rent_saleLabel.stringValue = @"Rent / Sale:";
    self.typeLabel.stringValue = @"Type:";
    self.agentLabel.stringValue = @"Agent:";
    self.bathroomsLabel.stringValue = @"Bathrooms:";
    self.contactDetailsLabel.stringValue = @"Contact Person: \n\nPhone Number:";
    self.priceLabel.stringValue = @"Price:";
    self.sqmLabel.stringValue = @"Area (in m2):";
    self.locationLabel.stringValue = @"Location:";
    self.floorLabel.stringValue = @"Floor:";
    self.rentedLabel.stringValue = @"Rented:";
}

#pragma mark - NSTableView Delegate
- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
    if ([self.dataTableView selectedRow] >= 0) {
        
        Apartement *aprt;
        if (filteredApartements) {
            aprt = [filteredApartements objectAtIndex:[self.dataTableView selectedRow]];
        } else {
            aprt = [apartements objectAtIndex:[self.dataTableView selectedRow]];
        }
        
        //populate the detail
        self.nameLabel.stringValue = [NSString stringWithFormat:@"Building Name: %@", aprt.buildingName];
        self.refLabel.stringValue = [NSString stringWithFormat:@"Reference: %@", aprt.reference];
        self.bedroomsLabel.stringValue = [NSString stringWithFormat:@"Bedrooms: %@", aprt.bedrooms];
        self.propertyOwnerLabel.stringValue = [NSString stringWithFormat:@"Property Owner: %@", aprt.propertyOwner];
        self.keyLocationLabel.stringValue = [NSString stringWithFormat:@"Key Location: %@", aprt.keyLocation];
        self.addOnLabel.stringValue = [NSString stringWithFormat:@"Add on: %@", aprt.addOn];
        self.parkingLabel.stringValue = [NSString stringWithFormat:@"Parking: %@", aprt.parking];
        self.commentsLabel.stringValue = [NSString stringWithFormat:@"Comments: %@", aprt.comments];
        self.rent_saleLabel.stringValue = [NSString stringWithFormat:@"Rent / Sale: %@", aprt.rent_sale];
        self.typeLabel.stringValue = [NSString stringWithFormat:@"Type: %@", aprt.type];
        self.agentLabel.stringValue = [NSString stringWithFormat:@"Agent: %@", aprt.agent];
        self.bathroomsLabel.stringValue = [NSString stringWithFormat:@"Bathrooms: %@", aprt.bathrooms];
        self.contactDetailsLabel.stringValue = [NSString stringWithFormat:@"Contact Person: %@ \n\nPhone Number: %@", aprt.contactPerson, aprt.contactNumber];
        self.priceLabel.stringValue = [NSString stringWithFormat:@"Price: %@", aprt.price];
        self.sqmLabel.stringValue = [NSString stringWithFormat:@"Area (in m2): %@", aprt.sqm];
        self.locationLabel.stringValue = [NSString stringWithFormat:@"Location: %@", aprt.location];
        self.floorLabel.stringValue = [NSString stringWithFormat:@"Floor: %@", aprt.floor];
        self.rentedLabel.stringValue = [NSString stringWithFormat:@"Rented: %@", aprt.rented];
    }
}


#pragma mark - Actions
- (IBAction)segementedControlClicked:(NSSegmentedControl *)sender {
    if (sender.selectedSegment == 0) {
        //plus button was pressed show the form
        NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ViewController *vc = [storyboard instantiateControllerWithIdentifier:@"vc"];
        [self presentViewControllerAsSheet:vc];
        vc.dataVC = self;
    } else if (sender.selectedSegment == 1 && [self.dataTableView selectedRow] >= 0){
        //minus button pressed delete the selected apartement
        Apartement *aprt = [apartements objectAtIndex:[self.dataTableView selectedRow]];
        [aprt deleteApartement];
        [self reloadData];
    }
}

- (IBAction)editApartement:(NSButton *)sender {
    if ([self.dataTableView selectedRow] >= 0) {
        NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ViewController *vc = [storyboard instantiateControllerWithIdentifier:@"vc"];
        
        //set the properties
        vc.dataVC = self;
        vc.aprt = [apartements objectAtIndex:[self.dataTableView selectedRow]];

        //show the form
        [self presentViewControllerAsSheet:vc];
    }
}

#pragma mark - Searching
- (IBAction)searchFieldSearch:(NSSearchField *)searchField {
    //get the search string
    NSString  *searchString = [searchField stringValue];
    
    if (![searchString isEqualToString:@""] && searchString) {
        
        //set the predicate depening on the category
        if ([category isEqualToString:@"Area"]) {
            searchPredicate = [NSPredicate predicateWithFormat:@"sqm  contains[cd] %@", searchString];
        
        } else if ([category isEqualToString:@"Reference"]) {
            searchPredicate = [NSPredicate predicateWithFormat:@"reference  contains[cd] %@", searchString];
        
        } else if ([category isEqualToString:@"Building Name"]) {
            searchPredicate = [NSPredicate predicateWithFormat:@"buildingName  contains[cd] %@", searchString];
        
        } else if ([category isEqualToString:@"Type"]) {
            searchPredicate = [NSPredicate predicateWithFormat:@"type  contains[cd] %@", searchString];
        
        } else if ([category isEqualToString:@"Location"]) {
            searchPredicate = [NSPredicate predicateWithFormat:@"location  contains[cd] %@", searchString];
        
        } else if ([category isEqualToString:@"Price"]) {
            searchPredicate = [NSPredicate predicateWithFormat:@"price  contains[cd] %@", searchString];
        
        } else if ([category isEqualToString:@"Rent / Sale"]) {
            searchPredicate = [NSPredicate predicateWithFormat:@"rent_sale  contains[cd] %@", searchString];
        
        } else if ([category isEqualToString:@"Property Owner"]) {
            searchPredicate = [NSPredicate predicateWithFormat:@"propertyOwner  contains[cd] %@", searchString];
        
        } else {
            searchPredicate = [NSPredicate predicateWithFormat:@"(reference contains[cd] %@) or (buildingName  contains[cd] %@) or (type  contains[cd] %@) or (sqm  contains[cd] %@) or (location  contains[cd] %@) or (price  contains[cd] %@) or (rent_sale  contains[cd] %@) or (propertyOwner  contains[cd] %@)",  searchString, searchString, searchString, searchString, searchString, searchString, searchString, searchString];
        }
        
        filteredApartements = [NSArray new];
        filteredApartements  = [apartements filteredArrayUsingPredicate:searchPredicate];
        [self reloadData];
        
    } else {
        filteredApartements = nil;
        [self reloadData];
    }
}

-(void)setSearchCategoryFrom:(NSMenuItem *)menuItem {
    category = menuItem.title;
}

@end
