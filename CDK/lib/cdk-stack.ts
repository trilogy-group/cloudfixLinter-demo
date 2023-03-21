import { Size, Stack, StackProps } from 'aws-cdk-lib';
import { Construct } from 'constructs';
import { aws_dynamodb as dynamodb } from 'aws-cdk-lib';
import { aws_ec2 as ec2 } from 'aws-cdk-lib';
import { aws_efs as efs  , aws_s3 as s3} from 'aws-cdk-lib';
import * as neptune from '@aws-cdk/aws-neptune-alpha';
import { EbsDeviceVolumeType } from 'aws-cdk-lib/aws-ec2';

export class CdkStack extends Stack {
  constructor(scope: Construct, id: string, props?: StackProps) {
    super(scope, id, props);


    //DynamoDB table 
    const table = new dynamodb.Table(this, 'cloudfixlinter-cdk', {
      partitionKey: { name: 'id', type: dynamodb.AttributeType.STRING },
      billingMode: dynamodb.BillingMode.PAY_PER_REQUEST,
    });

    //Ebs vol
    const volume = new ec2.Volume(this, 'DataVolume', {
      availabilityZone: 'us-east-1',
      size: Size.gibibytes(10),
      volumeType: EbsDeviceVolumeType.GENERAL_PURPOSE_SSD,
    })

    // vpc 
    const vpc = new ec2.Vpc(this, 'cloudfix-vpc-cdk', {
      maxAzs: 2
    });

    // EC2 instance - 1
    const instance = new ec2.Instance(this, 'AppServer', {
      instanceType: ec2.InstanceType.of(ec2.InstanceClass.T2, ec2.InstanceSize.MICRO),
      machineImage: ec2.MachineImage.latestAmazonLinux({
        generation: ec2.AmazonLinuxGeneration.AMAZON_LINUX_2,
      }),
      vpc : vpc
    });

    //Ec2 instance - 2
    new ec2.Instance(this, `cloudfix-instance-appserver-ckd`, {
      instanceType: ec2.InstanceType.of(ec2.InstanceClass.T2, ec2.InstanceSize.MICRO),
      machineImage: new ec2.AmazonLinuxImage(),
      vpc,
    });

    // NAT gateway
    new ec2.CfnNatGateway(this, 'cloudfix-Natgateway-cdk', {
      subnetId: 'subnet-0ad82a9a46e5aaf68',
      // the properties below are optional
      connectivityType: 'private',
    });

    // VPC endpoint
    new ec2.GatewayVpcEndpoint(this, 'cloudfix-MyVpcEndpoint-cdk', {
      service: { name: 'com.amazonaws.us-east-1.s3' },
      vpc,
    });

    //s3 Bucket - 1
    const bucket = new s3.Bucket(this, 'cloudfix-RemoteS3Bucket-cdk-1', {
      bucketName: "cloudfix-s3-bucket-1",
      versioned: true,
      accessControl: s3.BucketAccessControl.PRIVATE,
    });

    const bucket2 = new s3.Bucket(this, 'cloudfix-RemoteS3Bucket-cdk-2', {
      bucketName: "cloudfix-s3-bucket-1",
      versioned: true,
      accessControl: s3.BucketAccessControl.PUBLIC_READ_WRITE,
    });

    // EFS file system
    new efs.FileSystem(this, 'cloudfix-MyFileSystem-cdk', {
      vpc,
      encrypted: true,
    });


    //aws_s3_bucket_public_access_block

    //aws_s3_bucket_versioningterraforte

    //neptune DBCluster
    const cluster = new neptune.DatabaseCluster(this, 'cloudfix-Database-cdk', {
      vpc,
      instanceType: neptune.InstanceType.R5_LARGE,
    });

    
  }
}
