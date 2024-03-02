import logging
import os
import sys

import natcap.invest
from natcap.invest import datastack
from natcap.invest.scenic_quality import scenic_quality

if not os.path.exists(sys.argv[1]):
    os.makedirs(sys.argv[1])

logging.basicConfig(level=logging.INFO, filename=os.path.join(sys.argv[1], 'logfile.txt'))

args = datastack.extract_parameter_set('/natcap/ScenicQuality/scenic_quality_wcvi_sample.invest.json').args
args['workspace_dir'] = sys.argv[1],
scenic_quality.execute(args)
