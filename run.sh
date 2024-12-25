#/ bin/bash
ansible-playbook MoveRemoteSQL.yml && ansible-playbook cleanData.yml \
    && ansible-playbook Deploy.yml \
    && ansible-playbook ReturnRemoteSQL.yml && ansible-playbook CopyTRTfile.yml 