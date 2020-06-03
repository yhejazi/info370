# BigMart Sales Prediction

## Abstract

BigMart has amassed a large set of data
from their existing outlet stores and has
publicized them for the purpose of machine
learning. Identifying key features of stores
can enable for effective outlet management
of items and assist in solidifying sales
tactics. We first conducted exploratory data
analysis to identify areas of interest within
the data as well as linear regression with a
selected set of features. Thereafter receiving
our results of the linear regression, we
turned to various machine learning
algorithms before finalizing on with a
simple linear regression model. Overall our
methods and analysis have found two
features that companies should look to
prioritize when they want to sell an item
effectively; we found that to have a
successful item, in terms of sales, it needs to
be within a medium-sized Supermarket
Type 3 that lies in a Tier 2 / 3 location.

**Keywords**: BigMart, machine learning,
linear regression


## Introduction

Provided by Analytics Vidhya, an online
data science competition host, we have been
participating in the BigMart Sales Practice
Problem which began on May 25th, 2016,
and ends on December 31st, 2018. Data
scientists at BigMart have “collected 2013
sales data for 1559 products across 10 stores
in different cities”, which participants use to
build a model to predict product sales by
store. With this, BigMart will try to gain
understanding of product and store
properties that lead to increased sales.

Using data to increase profitability is now an
intuitive and common practice in business;
the type, number, and even physical
placement of products is no longer arbitrary,
rather, it is determined by data. Therefore,
this study echoes the common business
approach to increasing profitability:
data-driven decision making.

>Problem Statement: “The data scientists at
BigMart have collected 2013 sales data for
1559 products across 10 stores in different
cities. Also, certain attributes of each
product and store have been defined. The
aim is to build a predictive model and find
out the sales of each product at a particular
store. Using this model, BigMart will try to
understand the properties of products and
stores which play a key role in increasing
sales.”

The problem space we are interested in is
the relationship between the profitability of
a store and the factors that influence it such
as the items a store offers, their placement
on shelves, the size of stores, where the
stores are located, etc. Through this analysis
of the Big Mart dataset, we aim to identify
key factors that should be considered for
when companies like Big Mart advances
with opening new outlet stores or advancing
their sales in existing ones.
Some of the questions we will try to answer
specifically are:

1. What properties of a store are key
in determining store profitability?
2. What properties of store items are
key in determining product
profitability?
3. What items are most profitable in
each location?
4. What category of products are most
profitable in each location?
5. What types of location are most
profitable?

Specific hypotheses we will be testing
are:

1. Item visibility affects the sale of
the product
2. Outlet size, type and outlet location
type affects the profitability of a
store
3. Stores that are located in tier 1
cities or urban areas should have
higher sales because people who
live in these areas tend to have
higher levels of income