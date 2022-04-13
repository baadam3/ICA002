#!/bin/bash -ex

date > pre_exam.txt

exec > >(tee -ia pre_exam.txt) 2>&1

hostname

/home/balint/ansible-venv/bin/ansible-playbook infra.yaml --diff

/home/balint/ansible-venv/bin/ansible-playbook infra.yaml --diff

/home/balint/ansible-venv/bin/ansible all -b -m reboot -a "test_command=uptime"

/home/balint/ansible-venv/bin/ansible-playbook infra.yaml --diff

date

