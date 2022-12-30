import { Context, EventBridgeEvent } from 'aws-lambda';

const usersTable = process.env.USERS_TABLE_ARN

export const handler = async (event: EventBridgeEvent<any, any>, context: Context) : Promise<{}> => {
    console.log(`DynamoDB Table Arn: ${usersTable}`)
    return {};
};
