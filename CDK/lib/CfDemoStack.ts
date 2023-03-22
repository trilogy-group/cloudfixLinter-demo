import { Size, Stack, StackProps } from 'aws-cdk-lib';
import { Construct } from 'constructs';
import { aws_dynamodb as dynamodb } from 'aws-cdk-lib';
import { aws_ec2 as ec2 } from 'aws-cdk-lib';
import { aws_efs as efs, aws_s3 as s3 } from 'aws-cdk-lib';
import * as neptune from '@aws-cdk/aws-neptune-alpha';
import { EbsDeviceVolumeType, SubnetType, Vpc } from 'aws-cdk-lib/aws-ec2';
import { BucketEncryption } from 'aws-cdk-lib/aws-s3';
import * as cdk from 'aws-cdk-lib';

export class CfDemoStack extends Stack {
  constructor(scope: Construct, id: string, props?: StackProps) {
    super(scope, id, props);


    //DynamoDB table 
    const table = new dynamodb.Table(this, 'cloudfixlinter-cf', {
      partitionKey: { name: 'id', type: dynamodb.AttributeType.STRING },
      billingMode: dynamodb.BillingMode.PAY_PER_REQUEST,
    });

    //Ebs vol
    const volume = new ec2.Volume(this, 'cloudfix-cf-DataVolume', {
      availabilityZone: 'us-east-1a',
      size: Size.gibibytes(10),
      volumeType: EbsDeviceVolumeType.GENERAL_PURPOSE_SSD,
    })

    // vpc 
    const DefaultVpc = Vpc.fromVpcAttributes(this, 'cloudfix-cf-vpcdev', {
      vpcId: 'vpc-02badd8abb988e06e',
      availabilityZones: ['us-east-1a'],
      privateSubnetIds: ['subnet-0a1186feed91f0165'],
      publicSubnetIds: ['subnet-0c53c3bc75d9b66b2', 'subnet-0ad82a9a46e5aaf68'],
      publicSubnetRouteTableIds: ['rtb-055316860c9497d01', 'rtb-08f90b2a360aeb299'],
      privateSubnetRouteTableIds: ['rtb-08f90b2a360aeb299']
    });

    // EC2 instance - 1
    const instance = new ec2.Instance(this, 'cloudfix-cf-AppServer', {
      instanceType: ec2.InstanceType.of(ec2.InstanceClass.T2, ec2.InstanceSize.MICRO),
      machineImage: ec2.MachineImage.latestAmazonLinux({
        generation: ec2.AmazonLinuxGeneration.AMAZON_LINUX_2,
      }),
      vpc: DefaultVpc
    });

    //Ec2 instance - 2
    new ec2.Instance(this, `cloudfix-cf-instance-appserver`, {
      instanceType: ec2.InstanceType.of(ec2.InstanceClass.T2, ec2.InstanceSize.MICRO),
      machineImage: new ec2.GenericLinuxImage({
        'us-east-1': 'ami-09d56f8956ab235b3',
      }),
      vpc: DefaultVpc,

    });

    // NAT gateway
    new ec2.CfnNatGateway(this, 'cloudfix-cf-Natgateway', {
      subnetId: 'subnet-0ad82a9a46e5aaf68',
      // the properties below are optional
      connectivityType: 'private',
    });

    // VPC endpoint
    new ec2.GatewayVpcEndpoint(this, 'cloudfix-cf-MyVpcEndpoint', {
      service: { name: 'com.amazonaws.us-east-1.s3' },
      vpc: DefaultVpc,
      subnets: [
        { subnetType: ec2.SubnetType.PUBLIC }
      ],

    });

    //s3 Bucket - 1
    const bucket = new s3.Bucket(this, 'cloudfix-cf-s3-1', {
      bucketName: "cloudfix-s3-bucket-1",
      versioned: true,
      accessControl: s3.BucketAccessControl.PRIVATE,
    });

    const bucket2 = new s3.Bucket(this, 'cloudfix-cf-s3-2', {
      bucketName: "cloudfix-s3-bucket-2",
      encryption: BucketEncryption.S3_MANAGED,
      versioned: true,
      accessControl: s3.BucketAccessControl.PUBLIC_READ_WRITE,
    });

    // EFS file system
    new efs.FileSystem(this, 'cloudfix-cf-MyFileSystem', {
      vpc: DefaultVpc,
      encrypted: true,
    });


    //aws_s3_bucket_public_access_block

    //aws_s3_bucket_versioningterraforte

    //neptune DBCluster
    // const cluster = new neptune.DatabaseCluster(this, 'cloufix-cf-MyCluster', {
    //   instanceType: neptune.InstanceType.R5_LARGE,
    //   vpc: DefaultVpc,
    //   removalPolicy: cdk.RemovalPolicy.DESTROY,
    //   port: 8182,
    //   iamAuthentication: true,
    //   backupRetention: cdk.Duration.days(7),
    //   preferredBackupWindow: '03:00-04:00',
    //   vpcSubnets:{
    //     subnetType: SubnetType.PUBLIC 
    //   }
    // });


  }
}
