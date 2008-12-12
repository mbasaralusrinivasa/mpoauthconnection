//
//  OAuthClientController.m
//  MPOAuthConnection
//
//  Created by Karl Adam on 08.12.05.
//  Copyright 2008 matrixPointer. All rights reserved.
//

#import "OAuthClientController.h"
#import "MPOAuthAPI.h"

@implementation OAuthClientController

- (id)init {
	if (self = [super init]) {		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestTokenReceived:) name:MPOAuthNotificationRequestTokenReceived object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessTokenReceived:) name:MPOAuthNotificationAccessTokenReceived object:nil];
	}
	return self;
}

- (oneway void)dealloc {
	[_oauthAPI release];
	
	[super dealloc];
}

- (void)awakeFromNib {
	[progressIndicator setHidden:NO];
	[progressIndicator startAnimation:self];
}

- (void)requestTokenReceived:(NSNotification *)inNotification {
	[progressIndicator stopAnimation:self];
	[authenticationButton setTitle:@"Request User Access"];
}

- (void)accessTokenReceived:(NSNotification *)inNotification {
	[progressIndicator stopAnimation:self];
	[authenticationButton setTitle:@"Access Token Acquired"];
}

- (IBAction)performAuthentication:(id)sender {
	if (!_oauthAPI) {
		NSDictionary *credentials = [NSDictionary dictionaryWithObjectsAndKeys:	[consumerKeyField stringValue], kMPOAuthCredentialConsumerKey,
																				[consumerSecretField stringValue], kMPOAuthCredentialConsumerSecret,
																				nil];
		_oauthAPI = [[MPOAuthAPI alloc] initWithCredentials:credentials
										  authenticationURL:[NSURL URLWithString:@"https://api.login.yahoo.com/oauth/v2/"]
												 andBaseURL:[NSURL URLWithString:@"http://social.yahooapis.com/v1/"]];		
	} else {
		[_oauthAPI authenticate];
	}
}

- (IBAction)performMethod:(id)sender {
	[_oauthAPI performMethod:[methodField stringValue] withTarget:self andAction:@selector(performedMethodLoadForURL:withResponseBody:)];
}

- (void)performedMethodLoadForURL:(NSURL *)inMethod withResponseBody:(NSString *)inResponseBody {
	[responseBodyView setString:inResponseBody];
}

@end
