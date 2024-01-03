echo $'\n'
echo "Intance Security information (All Instances)"
echo "-----------------------------------------------------------"
aws ec2 describe-instances \
--query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,PrivateIP:PrivateIpAddress,Name:Tags[?Key=='Name'].Value|[0],Status:State.Name,VpcId:VpcId,InstanceID:InstanceId,Groups:join(',',NetworkInterfaces[].Groups[].GroupId),IamInstanceProfile:IamInstanceProfile.Arn}" \
--region $1 | jq

echo $'\n'
echo "Intance Security information (Running STATE)"
echo "-----------------------------------------------------------"
aws ec2 describe-instances \
--query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,PrivateIP:PrivateIpAddress,Name:Tags[?Key=='Name'].Value|[0],Status:State.Name,VpcId:VpcId,InstanceID:InstanceId,Groups:join(',',NetworkInterfaces[].Groups[].GroupId),IamInstanceProfile:IamInstanceProfile.Arn}" \
--filters "Name=instance-state-name,Values=running" \
--output json --region $1 | jq

echo $'\n'
echo "Intance Security information (Stopped STATE)"
echo "-----------------------------------------------------------"
aws ec2 describe-instances \
--query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,PrivateIP:PrivateIpAddress,Name:Tags[?Key=='Name'].Value|[0],Status:State.Name,VpcId:VpcId,InstanceID:InstanceId,Groups:join(',',NetworkInterfaces[].Groups[].GroupId),IamInstanceProfile:IamInstanceProfile.Arn}" \
--filters "Name=instance-state-name,Values=stopped" \
--output json --region $1 | jq

echo $'\n'
echo " Account Policies"
echo "-----------------------------------------------------------"
aws iam list-policies --scope Local --only-attached --query "Policies[].Arn" --region $1 | jq

echo $'\n'
echo " Account Roles "
echo "-----------------------------------------------------------"
for role in $(aws iam list-roles --region $1 | jq -r '.Roles[].RoleName')
do 
    echo $role; 
done

echo $'\n'
echo " Role Policies x Account Role "
echo "-----------------------------------------------------------"
for role in $(aws iam list-roles --region $1 | jq -r '.Roles[].RoleName')
do 
    echo $role; 
    aws iam list-role-policies --role-name $role --region $1 | jq 
    echo "-------------"
    echo $'\n'
done

