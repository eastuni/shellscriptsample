for tdir in ./*
do
  echo $tdir
  if [[ -d $tdir ]];then
    echo "tar"
    cd $tdir
    tar -czf sql.tar.gz *.sql
    rm -f *.sql
    cd ..
  fi
done
