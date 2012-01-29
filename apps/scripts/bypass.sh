#!/bin/bash
ssh -p 1108 -CqTnN -L 192.168.1.103:9999:localhost:8888 larry@199.180.250.171
