Select *
From House.dbo.House_Details;

--------------------------------------------------------------------------------------------------------------------------
-- Standardizing Date Format
ALTER TABLE House_Details
Add SaleDateConverted Date;

Update House_Details
SET SaleDateConverted = CONVERT(Date,SaleDate)

--------------------------------------------------------------------------------------------------------------------------
-- Populating Property Address data
Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From dbo.House_Details a
JOIN dbo.House_Details b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null
order by a.ParcelID

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From dbo.House_Details a
JOIN dbo.House_Details b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

--------------------------------------------------------------------------------------------------------------------------

-- Breaking on Address into Individual Columns (Address, City, State)
Select PropertyAddress
From dbo.House_Details;
--Where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From dbo.House_Details;


ALTER TABLE House_Details
Add PropertySplitAddress Nvarchar(255);

Update House_Details
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE House_Details
Add PropertySplitCity Nvarchar(255);

Update House_Details
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))




Select *
From dbo.House_Details





Select OwnerAddress
From dbo.House_Details


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From dbo.House_Details



ALTER TABLE House_Details
Add OwnerSplitAddress Nvarchar(255);

Update House_Details
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE House_Details
Add OwnerSplitCity Nvarchar(255);

Update House_Details
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE House_Details
Add OwnerSplitState Nvarchar(255);

Update House_Details
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



Select *
From dbo.House_Details
