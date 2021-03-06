//
//  AppDelegate.m
//  RaisedEditor2
//
//  Created by Andy Kim on 1/29/08.
//  Copyright 2008 Potion Factory LLC. All rights reserved.
//

#import "AppDelegate.h"

#import <PotionStorefront/PotionStorefront.h>

@implementation AppDelegate

- (IBAction)buy:(id)sender
{
	[[PotionStorefront sharedStorefront] setDelegate:self];
	[[PotionStorefront sharedStorefront] setPotionStoreURL:[NSURL URLWithString:@"http://localhost:3000/store"]];
	[[PotionStorefront sharedStorefront] setProductsPlistURL:[NSURL URLWithString:@"http://getconcentrating.com/c8_storefront_products.plist"]];
	[[PotionStorefront sharedStorefront] setWebStoreSupportsPayPal:YES googleCheckout:YES];
    [[PotionStorefront sharedStorefront] setHeaderBackgroundColor:[NSColor redColor] andTextColor:[NSColor blueColor]];
    
	[[PotionStorefront sharedStorefront] beginSheetModalForWindow:mainWindow];
}



//------------------------------------------------------------------------------
// validate:
//------------------------------------------------------------------------------
- (IBAction) validate:(id)sender
{
    [spinner startAnimation:self];
    
    [[PotionStorefront sharedStorefront] setDelegate:self];
	[[PotionStorefront sharedStorefront] setPotionStoreURL:[NSURL URLWithString:@"http://localhost:3000/store"]];
    [[PotionStorefront sharedStorefront] validateLicenseName:[nameTextField stringValue] andKey:[licenseTextField stringValue]];
}


- (void)licenseValidated:(BOOL)response
{
    [spinner stopAnimation:self];
    
    NSAlert *alert = [NSAlert alertWithMessageText:@"Validation Response" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"License validation %@", response ? @"succeeded" : @"failed"];
    [alert runModal];
}
@end
