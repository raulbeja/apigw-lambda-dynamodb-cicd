var AWS = require('aws-sdk');
var ddb = new AWS.DynamoDB({apiVersion: '2012-08-10'});

exports.handler = async (event) => {
    try {
	    var payload = JSON.parse(event.body);
	    var dbread_write = payload.operation;

        var ID = payload.id;
        switch(dbread_write){
            case "write":
                var NAME = payload.name;
                var params = {
                    TableName:process.env.table_name,
                    Item: {
                        id : {S: ID}, 
                        name : {S: NAME}
                    }
                };
                var data;
                var msg;
                
                try{
                    data = await ddb.putItem(params).promise();
                    console.log("Operation successfully entered:", data);
                    msg = 'Operation successfully entered V1';
                } catch(err){
                    console.log("Error: ", err);
                    msg = err;
                }
                
                var response = {
                    'statusCode': 200,
                    'body': JSON.stringify({
                        message: msg
                    })
                };
                break;

            case "read":
                var params = {
                    TableName:process.env.table_name,
                    Key: {
                        id : {S: ID}
                    }
                };
                
                var data;
                
                try{
                    data = await ddb.getItem(params).promise();
                    console.log("Operation successfully entered:", data);
                } catch(err){
                    console.log("Error: ", err);
                    data = err;
                }
                
                var response = {
                    'statusCode': 200,
                    'body': JSON.stringify({
                        message: data
                    })
                };
                break;

            default:
                var response = {
                    'statusCode': 200,
                    'body': JSON.stringify({
                        message: "Invalid operation"
                    })
                };
        }

    } catch (err) {
	    console.log(err);
	    return err;
    }

    return response;
};