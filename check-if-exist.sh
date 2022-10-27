declare -a arr=("kubectl" "helm" "terraform" "jenkins" "docker") 

for i in "${arr[@]}"
do
    if command -v $i > /dev/null
    then
    echo $i exists
    else
    echo $i does not exist
    echo started to $i
    fi
done