//
//  PotionStorefront.m
//  PotionStorefront
//
//  Created by Andy Kim on 7/26/08.
//  Copyright 2008 Potion Factory LLC. All rights reserved.
//

#import "PotionStorefront.h"
#import "PFStoreWindowController.h"
#import <JSON/JSON.h>

@implementation PotionStorefront

static PotionStorefront *gStorefront = nil;

+ (PotionStorefront *)sharedStorefront
{
	if (gStorefront == nil) {
		gStorefront = [[PotionStorefront alloc] init];
	}
	return gStorefront;
}

- (id)delegate
{
	return [[PFStoreWindowController sharedController] delegate];
}

- (void)setDelegate:(id)delegate
{
	[[PFStoreWindowController sharedController] setDelegate:delegate];
}

- (NSURL *)potionStoreURL
{
	return [[PFStoreWindowController sharedController] storeURL];
}

- (void)setPotionStoreURL:(NSURL *)URL
{
	[[PFStoreWindowController sharedController] setStoreURL:URL];
}

- (NSURL *)productsPlistURL
{
	return [[PFStoreWindowController sharedController] productsPlistURL];
}

- (void)setProductsPlistURL:(NSURL *)URL
{
	[[PFStoreWindowController sharedController] setProductsPlistURL:URL];
}

- (void)setWebStoreSupportsPayPal:(BOOL)flag1 googleCheckout:(BOOL)flag2
{
	[[PFStoreWindowController sharedController] setWebStoreSupportsPayPal:flag1 googleCheckout:flag2];
}

- (void)beginSheetModalForWindow:(NSWindow *)window
{
	NSWindow *storeWindow = [[PFStoreWindowController sharedController] window];

	// Don't open twice
	if ([storeWindow isVisible]) {
		[storeWindow makeKeyAndOrderFront:self];
		return;
	}

	// Call the showPricing: action here because by now the delegate should be set
	[[PFStoreWindowController sharedController] showPricing:nil];

	[NSApp beginSheet:storeWindow
	   modalForWindow:window
		modalDelegate:self
	   didEndSelector:nil
		  contextInfo:NULL];

	// Clear the first responder. By default it's getting set to the web store button, and that looks quite fugly
	[storeWindow makeFirstResponder:nil];
}


- (void)setHeaderBackgroundColor:(NSColor *)bgColor andTextColor:(NSColor *)textColor
{
    [[PFStoreWindowController sharedController] setHeaderBackgroundColor:bgColor];
    [[PFStoreWindowController sharedController] setHeaderTextColor:textColor];
}


//------------------------------------------------------------------------------
// validateLicenseName:andKey:
//------------------------------------------------------------------------------
- (void) validateLicenseName:(NSString *)name andKey:(NSString *)key
{
    // ping their store's validate_license and see if we get a 200 or 404
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:name, key, nil] forKeys:[NSArray arrayWithObjects:@"name", @"key", nil]];
    
    [NSThread detachNewThreadSelector:@selector(validateLicense:) toTarget:self withObject:dict];
}



//------------------------------------------------------------------------------
// validateLicense:
//------------------------------------------------------------------------------
- (void) validateLicense:(NSDictionary *)aDict
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSError *error = nil;
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/validate_license", [[self potionStoreURL] absoluteString]]]];
    NSHTTPURLResponse *response = nil;
    NSString *json = [aDict JSONRepresentation];
    
    if (DEBUG_POTION_STORE_FRONT) {
        NSLog(@"SENDING JSON: %@", json);
    }
    
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [postRequest setValue:@"PotionStorefront" forHTTPHeaderField:@"User-Agent"];
    [postRequest setHTTPBody:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [postRequest setTimeoutInterval:10.0];
    
    BOOL validated = YES;
    [NSURLConnection sendSynchronousRequest:postRequest returningResponse:&response error:&error];
    if (error != nil || [response statusCode] != 200) {
        validated = NO;
    }
    
    if ([[self delegate] respondsToSelector:@selector(licenseValidated:)]) {
        [[self delegate] licenseValidated:validated];
    }
    
    [pool release];
}

@end
