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
--------------------------------------------------------------------------------------------------------------------------
--Changing Y and N to Yes and No in "Sold as Vacant" field
Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From dbo.House_Details
Group by SoldAsVacant
order by 2




Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From dbo.House_Details


Update House_Details
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Removing Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) as row_num

From House_Details
--order by ParcelID
)
DELETE 
From RowNumCTE
Where row_num > 1




 Select *
From dbo.House_Details

---------------------------------------------------------------------------------------------------------
-- Deleting Unused Columns


ALTER TABLE House_Details
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

 Select *
From dbo.House_Details
