# %%
import matplotlib.pyplot as plt
import numpy as np
import gvar as gv

def bootstrap(conf_ls, N_re):
    N_conf = len(conf_ls)
    conf_re = []
    for times in range(N_re):
        idx_ls = np.random.randint(N_conf, size=N_conf)
        temp = []
        for idx in idx_ls:
            temp.append(conf_ls[idx])
        conf_re.append( np.average(temp, axis=0) )

    return np.array(conf_re)

errorb = {"markersize": 5, 'marker': 'o', "mfc": "none", "linestyle": "none", "capsize": 3, "elinewidth": 1}

# %%
data_dic = {}

with open("pion_s080_2pt_code.txt", "r") as f:
    data = f.readlines()
    for line in data:
        line = line.split()
        if line[0] not in data_dic:
            data_dic[line[0]] = []
        data_dic[line[0]].append([int(line[1]), float(line[2]), ])

Nt = 96
pt2_ls = []
for key in data_dic:
    temp_ls = []
    for t in range(int(Nt/2)):
        temp_ls.append( (data_dic[key][t][1] + data_dic[key][Nt-t-1][1])/2 )
    pt2_ls.append(temp_ls)

pt2_ls_bs = bootstrap(pt2_ls, 100)


meff_ls = []
for n_conf in range(len(pt2_ls_bs)):
    meff_ls.append([])
    for t in range(int(Nt/2)-1):
        meff_ls[n_conf].append( np.log(pt2_ls_bs[n_conf][t] / pt2_ls_bs[n_conf][t+1]) * 0.197 / 0.08 )

meff_ls_avg = gv.dataset.avg_data(meff_ls, bstrap=True)

plt.errorbar(np.arange(int(Nt/2)-1), [val.mean for val in meff_ls_avg], [val.sdev for val in meff_ls_avg], **errorb)
plt.plot(np.arange(6, 32), 3*np.ones(32-6), label='3')
plt.xlim([6, 32])
#plt.ylim([0.1, 0.5])
plt.ylabel('meff')
plt.legend()
plt.show()

print(meff_ls_avg[3:])


# %%
