ec2_instance { 'Puppet-Client-1':
  ensure            => present,
  region            => 'us-east-1',
  availability_zone => 'us-east-1c',
  subnet            => 'POC-PUB1',
  image_id          => 'ami-fce3c696',
  instance_type     => 't2.micro',
  monitoring        => false,
  key_name          => 'protonmail-east',
  iam_instance_profile_name	=> 'S3_Access',
  security_groups   => ['default'],
  user_data         => template('/home/ubuntu/setup.sh'),
  tags              => {
    tag_name => 'test',
  },
}

