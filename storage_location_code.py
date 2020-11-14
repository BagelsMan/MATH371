#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Oct 19 17:33:27 2020

@author: Mary McCafferty
"""








"""

Lets decide on 3? methods of locating the storage containers
and apply it to 3 different combinations of storage (i.e. all together, 2 + 1, all separate)


SIMPLE WEIGHT MODEL:
function which weights hospitals by accessibility, medpack demand, other variables?
object: hospital(medpack1, medpack2, medpack3, longitude/latitude?)
GetHospitalWeights(h)
store weights as attributes of the hosiptals
- weights the hosiptals in three different ways for locating where to place storage units

function which determines location(s) by hospital weights
locate(hospitals, num_loc)
    where hospitals is a list of the hospitals 
    num_loc is the number of storage locations we want to use
    output should be a longitude and latitude
    - perhaps we limit the potential outputs to longitudes and latitudes along roads?
I am not really sure how to do that in code
Can we map major roads somehow?
explore matplotlib.basemap?




INTERSECTIONS MODEL:
identify the longitude and latitude of where on a straight edge graph intersects



minimize total travel paths? place storage containers at most central hospital


should we just use these functions to determine location by adjusting fixed parameters for hospitals
which varies the hospital weights?



have the output to the functions include the ratio/ number of medpacks

also need to implement the cost function
optomize the cost function- difficulty in optimizing number of storage locations
could compare number of locations by hand

followed by separate optomization of flight paths

"""

from math import sqrt
import numpy as np
import pandas as pd
import seaborn as sns
from scipy.spatial import distance_matrix
from itertools import permutations


class Hospital:
    """A hospital object class
    Attributes:
        loc_name(str) = full name of the hospital
        lat(float) = latitude of the hospital
        lon(float) = longitude of the hospital
        med1, med2, med3(int) = demand of a given medpack at the hospital
    """
    def __init__(self, loc_name, lat, lon, med1, med2, med3):
        self.loc_name = loc_name
        self.lat = lat
        self.lon = lon
        self.med1 = med1
        self.med2 = med2
        self.med3 = med3
    
    def __str__(self):
        return "Hospital:" + "\t" + str(self.loc_name) + "\n" + "Location:" + "\t" + "(" + str(self.lon) + "," + str(self.lat) + ")" + "\n" + "Medpack need:" + "\t"+ "(" + str(self.med1) + "," + str(self.med2) + "," + str(self.med3) + ")"

    def distance(self, other):
        return sqrt((self.lat-other.lat)**2 + (self.lon-other.lon)**2)
    
    def need(self):
        return self.med1 + self.med2 + self.med3
    

cmc = Hospital("Carribean Medical Center", 18.33, -65.65, 1, 0, 1)
hima = Hospital("Hospital HIMA", 18.22, -66.03, 2, 0, 1)
sanct = Hospital("Hospital Pavia Sancturce", 18.44, -66.07, 1, 1, 0)
child = Hospital("Puerto Rico Children's Hospital", 18.40, -66.16, 2, 1, 2)
arec = Hospital("Hospital Pavia Arecibo", 18.47, -66.73, 1, 0, 0)
        


hospitals = pd.DataFrame([["cmc", 18.33, -65.65, 1, 0, 1, 2], 
                         ["hima", 18.22, -66.03, 2, 0, 1, 3],
                         ["sanct", 18.44, -66.07, 1, 1, 0, 2],
                         ["child", 18.40, -66.16, 2, 1, 2, 5],
                         ["arec", 18.47, -66.73, 1, 0, 0, 1]],
                         columns = ['name', 'lon', 'lat', 'med1', 'med2', 'med3', 'total_med'])

w_lon = hospitals.total_med * hospitals.lon
hospitals['w_lon'] = w_lon
w_lat = hospitals.total_med * hospitals.lat
hospitals['w_lat'] = w_lat

names = ["cmc", "hima", "sanct", "child", "arec"]



locations = pd.DataFrame([[cmc.lon, cmc.lat], [hima.lon, hima.lat], [sanct.lon, sanct.lat], [child.lon, child.lat], [arec.lon, arec.lat]], columns = ("longitude", "latitude"), index = names)
pd.DataFrame(distance_matrix(locations.values, locations.values), index= locations.index, columns = locations.index)

    

def storage_locations(loc_num):
    """ For this first function of location, we are going to weight the hospitals simply by medpack
    need and place the storage units accordingly
    loc_num = number of locations we will be using for storage
    

    minimize distance between storage locations and hospitals, 
    for loc_num >1 maximize distance between storage locations
    for 2 and 3, group hospitals by proximity + need (minimizing both)
    """
    names = ["cmc", "hima", "sanct", "child", "arec"]
    if loc_num == 1:
        longitude = (Hospital.need(cmc)*cmc.lon + Hospital.need(hima)*hima.lon + Hospital.need(sanct)*sanct.lon + Hospital.need(child)*child.lon + Hospital.need(arec)*arec.lon)/13
        latitude = (Hospital.need(cmc)*cmc.lat + Hospital.need(hima)*hima.lat + Hospital.need(sanct)*sanct.lat + Hospital.need(child)*child.lat + Hospital.need(arec)*arec.lat)/13
        return pd.DataFrame([[round(longitude, 2), round(latitude, 2)]])
    
    elif loc_num == 2:
        groups1 = [1, 1, 1, 1, 2]
        groups2 = [1, 1, 1, 2, 2]
        rearrangements1 = pd.DataFrame(np.unique(np.array(list(permutations(groups1))), axis = 0), columns = names)
        rearrangements2 = pd.DataFrame(np.unique(np.array(list(permutations(groups2))), axis = 0), columns = names)    
        all_combos = pd.DataFrame(np.concatenate((rearrangements1, rearrangements2)), columns = names)
        #split 5 distinct hospitals into 2 nonempty distinct groups
        #groups must be distinct because one will have 2 storage bins and the other will have 1        
        bin1_longitude, bin1_latitude = [], []
        bin2_longitude, bin2_latitude = [], []
        loc_w_2bins = []             
        for row in list(range(all_combos.shape[0])):
        #iterate through the rows    
            a, b = [], []
            #establish three empty lists for the three different groups
            for i in all_combos.columns:
            #iterate across the columns
                m1, m2 = [], []
                #establish an empty list to create a mask
                if all_combos[i][row] == 1:
                #check which columns are in group 1
                    a.append(i)
                    #append those column names to list a
                    for j in list(range(hospitals.shape[0])):
                    #check which hospitals are in group 1 and subset the 'hospitals' dataframe accordiingly
                        m1.append(hospitals.name[j] in a)
                    df1 = hospitals[m1]   
           
                elif all_combos[i][row] == 2:
                #check which columns are in group 2
                    b.append(i)
                    #append those column names to list a
                    for j in list(range(hospitals.shape[0])):
                    #check which hospitals are in group 1 and subset the 'hospitals' dataframe accordiingly
                        m2.append(hospitals.name[j] in b)
                    df2 = hospitals[m2]
            bin1_longitude.append(df1.w_lon.sum() / df1.total_med.sum())
            bin1_latitude.append(df1.w_lat.sum() / df1.total_med.sum())            
            bin2_longitude.append(df2.w_lon.sum() / df2.total_med.sum())
            bin2_latitude.append(df2.w_lat.sum() / df2.total_med.sum())
            if (df1.total_med.sum() > df2.total_med.sum()):
                loc_w_2bins.append(1)
            else:
                loc_w_2bins.append(2)
        all_combos['bin1_lon'], all_combos['bin1_lat'] = bin1_longitude, bin1_latitude
        all_combos['bin2_lon'], all_combos['bin2_lat'] = bin2_longitude, bin2_latitude
        all_combos['loc_w_2bins'] = loc_w_2bins
        return all_combos
            

    elif loc_num == 3:
        #split the 5 distinct hospitals into 3 nonempty groups
        #5 distinct objects into 3 indentical groups, each with at least 1 object
        #5 choose 3 + 2 * 5 choose 2 = 5!/(2!*3!) + 2* 5!/(2!*3!) = 10 + 20 = 30
        #list all possible combinations to groups hospitals with 3 storage locations
        groups1 = [1, 1, 2, 2, 3]
        groups2 = [1, 1, 1, 2, 3]
        rearrangements1 = np.unique(np.array(list(permutations(groups1))), axis = 0)
        rearrangements2 = np.unique(np.array(list(permutations(groups2))), axis = 0)   
        all_combos = pd.DataFrame(np.concatenate((rearrangements1, rearrangements2)), columns = names)
        #want to iterate through the rows of all_combos and find corresponding storage locations
        #output variables are bin1, bin2, and bin3 corresponding to the number which the hospital has been assigned
        bin1_longitude, bin1_latitude = [], []
        bin2_longitude, bin2_latitude = [], []
        bin3_longitude, bin3_latitude = [], []        
        for row in list(range(all_combos.shape[0])):
        #iterate through the rows    
            a, b, c = [], [], []
            #establish three empty lists for the three different groups            
            for i in all_combos.columns:
            #iterate across the columns
                m1, m2, m3 = [], [], []
                #establish an empty list to create a mask
                if all_combos[i][row] == 1:
                #check which columns are in group 1
                    a.append(i)
                    #append those column names to list a
                    for j in list(range(hospitals.shape[0])):
                    #check which hospitals are in group 1 and subset the 'hospitals' dataframe accordiingly
                        m1.append(hospitals.name[j] in a)
                    df1 = hospitals[m1]              
                elif all_combos[i][row] == 2:
                #check which columns are in group 2
                    b.append(i)
                    #append those column names to list a
                    for j in list(range(hospitals.shape[0])):
                    #check which hospitals are in group 1 and subset the 'hospitals' dataframe accordiingly
                        m2.append(hospitals.name[j] in b)
                    df2 = hospitals[m2]
                elif all_combos[i][row] == 3:
                #check which columns are in group 3
                    c.append(i)
                    #append those column names to list a
                    for j in list(range(hospitals.shape[0])):
                    #check which hospitals are in group 1 and subset the 'hospitals' dataframe accordiingly
                        m3.append(hospitals.name[j] in c)
                    df3 = hospitals[m3]                 
            bin1_longitude.append(df1.w_lon.sum() / df1.total_med.sum())
            bin1_latitude.append(df1.w_lat.sum() / df1.total_med.sum())            
            bin2_longitude.append(df2.w_lon.sum() / df2.total_med.sum())
            bin2_latitude.append(df2.w_lat.sum() / df2.total_med.sum())            
            bin3_longitude.append(df3.w_lon.sum() / df3.total_med.sum())
            bin3_latitude.append(df3.w_lat.sum() / df3.total_med.sum())
        all_combos['bin1_lon'], all_combos['bin1_lat'] = bin1_longitude, bin1_latitude
        all_combos['bin2_lon'], all_combos['bin2_lat'] = bin2_longitude, bin2_latitude
        all_combos['bin3_lon'], all_combos['bin3_lat'] = bin3_longitude, bin3_latitude
        
        return all_combos
        

    
one = storage_locations(1)    
two = storage_locations(2)
#I think we just assign which ever storage location is servicing more medpacks to be the one with 2 bins
three = storage_locations(3)

one.to_excel("storage_locations1.xlsx", sheet_name = "one_loc")
two.to_excel("storage_locations2.xlsx", sheet_name = "two_loc")
three.to_excel("storage_locations3.xlsx", sheet_name = "three_loc")

locations = np.array([[cmc.lon, cmc.lat], [hima.lon, hima.lat], [sanct.lon, sanct.lat], [child.lon, child.lat], [arec.lon, arec.lat], [one[0], one[1]]])
#will need to convert it to a pandas dataframe so we can color code the plot

sns.scatterplot(locations[:,0], locations[:,1])
#idea for graphing is we can overlay it on to a map to compare it to the roads









