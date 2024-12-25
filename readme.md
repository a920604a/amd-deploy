ansible-playbook xxx.yml

1. MoveRemoteSQL.yml on remote, Move database on remote to tmp folder 
2. build app
3. cleanData.yml on localhost, clean database on local, and then init db, insert db
4. Deploy.yml on all
5. ReturnRemoteSQL.yml on remote, Move database on remote on tmp folder to amd_Data/StreamingAssets/ folder
6. CopyTRTfile.yml on remote 