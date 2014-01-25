//
//  ANKClient+AATTMessageManager.m
//  MessageBeast
//
//  Created by Rob Brambley on 10/31/13.
//  Copyright (c) 2013 Always All The Time. All rights reserved.
//

#import <AFHTTPClient.h>
#import <ANKClient+ANKRequestsAPI.h>

@implementation ANKClient (AATTMessageManager)

- (ANKJSONRequestOperation *)fetchMessageWithID:(NSString *)messageID inChannelWithID:(NSString *)channelID parameters:(NSDictionary *)parameters completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:[NSString stringWithFormat:@"channels/%@/messages/%@", channelID, messageID]
					 parameters:parameters
						success:[self successHandlerForResourceClass:[ANKMessage class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}

- (ANKJSONRequestOperation *)fetchMessagesInChannelWithID:(NSString *)channelID parameters:(NSDictionary *)parameters completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:[NSString stringWithFormat:@"channels/%@/messages", channelID]
					 parameters:parameters
						success:[self successHandlerForCollectionOfResourceClass:[ANKMessage class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}

- (ANKJSONRequestOperation *)fetchCurrentUserSubscribedChannelsWithTypes:(NSArray *)types parameters:(NSDictionary *)additionalParameters completion:(ANKClientCompletionBlock)completionHandler {
	if (!types) {
		types = @[];
	}
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:additionalParameters];
    [parameters setObject:[types componentsJoinedByString:@","] forKey:@"channel_types"];
       
	return [self enqueueGETPath:@"channels"
					 parameters:parameters
						success:[self successHandlerForCollectionOfResourceClass:[ANKChannel class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}

@end