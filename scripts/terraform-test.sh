#!/usr/bin/env sh

terraformVersionFile="tfversion.md"
echo "" > $terraformVersionFile
version=""

f=${1}
success=true
# echo $f
exitCode=0
echo ""
echo "====> Terraform testing in" $f
terraform -chdir=$f init -upgrade >/dev/null
if [[ $? -ne 0 ]]; then
  success=false
  exitCode=1
  echo -e "\033[31m[ERROR]\033[0m: running terraform init failed."
else
  echo ""
  echo "----> Plan Testing"
  terraform -chdir=$f plan >/dev/null
  if [[ $? -ne 0 ]]; then
    success=false
    exitCode=2
    echo -e "\033[31m[ERROR]\033[0m: running terraform plan failed."
  else
    echo -e "\033[32m - plan check: success\033[0m"
    echo ""
    echo "----> Apply Testing"
    terraform -chdir=$f apply -auto-approve >/dev/null
    if [[ $? -ne 0 ]]; then
        success=false
        exitCode=3
        echo -e "\033[31m[ERROR]\033[0m: running terraform apply failed."
    else
        echo -e "\033[32m - apply check: success\033[0m"
        echo ""
        echo -e " ----> Apply Diff Checking\n"
        terraform -chdir=$f plan -detailed-exitcode
        if [[ $? -ne 0 ]]; then
          success=false
          exitCode=4
          echo -e "\033[31m[ERROR]\033[0m: running terraform plan for checking diff failed."
        else
          echo -e "\033[32m - apply diff check: success\033[0m"
        fi
    fi
    echo ""
    echo " ----> Destroying"
    terraform -chdir=$f destroy -auto-approve >/dev/null 
    if [[ $? -ne 0 ]]; then
      success=false
      if [[ $exitCode -eq 0 ]]; then
        exitCode=5
      fi
      echo -e "\033[31m[ERROR]\033[0m: running terraform destroy failed."
    else
      echo -e "\033[32m - destroy: success\033[0m"
    fi
  fi
fi

version=$(terraform -chdir=$f version)
row=`echo -e "$version" | sed -n '/^$/='`
if [ -n "$row" ]; then
    version=`echo -e "$version" | sed -n "1,${row}p"`
fi  

if [[ $exitCode -ne 1 ]]; then
  rm -rf $f/.terraform
  rm -rf $f/.terraform.lock.hcl
fi

echo -e "### Versions\n" >> $terraformVersionFile 
echo -e "${version}" >> $terraformVersionFile 

exit $exitCode