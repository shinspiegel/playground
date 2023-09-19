import React, { useEffect, useState } from 'react';
import { useHistory, useParams } from 'react-router-dom';
import './index.css';

import useActions from '../../context/useActions';
import { findGroceryList, findProduct } from '../../utils';

import ProductSelectName from '../../components/ProductSelectName';
import ProductSelectInput from '../../components/ProductSelectInput';
import BaseButton from '../../components/BaseButton';

const ProductSelect = () => {
  const { push } = useHistory();
  const { product_id, year, week } = useParams();
  const [productsList, setProductsList] = useState([]);
  const { state, getProductsByName, updateList } = useActions();
  const { groceryList } = state;

  const selectedList = findGroceryList(groceryList, year, week);
  const selectedProduct = selectedList ? findProduct(selectedList.productsList, product_id) : null;
  const selectedProductName = selectedProduct ? selectedProduct.productName : null;

  useEffect(() => {
    if (groceryList.length === 0) {
      push('/login');
    }
  }, [productsList]);

  useEffect(() => {
    const getProducts = async () => {
      if (selectedProduct) {
        const findedProducts = await getProductsByName(selectedProduct.productName);
        setProductsList(findedProducts);
      }
    };

    getProducts();
  }, [selectedProductName]);

  const getProductName = () => {
    if (!selectedProduct) return '';
    return selectedProduct.productName;
  };

  const onChangeProductName = (value) => {
    if (!selectedProduct || !selectedList) return;

    const newList = [...selectedList.productsList];
    const index = newList.findIndex((product) => product._id === selectedProduct._id);
    newList[index] = { ...selectedProduct, productName: value };

    updateList({ updatedList: newList, listId: selectedList._id, year, week });
  };

  const onChangeProductSelect = (value) => {
    if (!selectedProduct || !selectedList) return;

    const newList = [...selectedList.productsList];
    const index = newList.findIndex((product) => product._id === selectedProduct._id);
    newList[index] = { ...selectedProduct, productReference: { _id: value } };

    updateList({ updatedList: newList, listId: selectedList._id, year, week });
  };

  const isChecked = (productId) => {
    if (
      selectedProduct &&
      selectedProduct.productReference &&
      selectedProduct.productReference._id === productId
    ) {
      return true;
    }

    return false;
  };

  const buttonHandler = () => {
    push(`/list/${year}/${week}`);
  };

  return (
    <>
      <main className='productSelect'>
        <ProductSelectName initialValue={getProductName()} onChange={onChangeProductName} />

        <form className='productSelect-form'>
          <ul>
            {productsList.map((product) => (
              <ProductSelectInput
                key={product._id}
                value={product._id}
                label={product.product}
                price={product.price}
                isChecked={isChecked(product._id)}
                onChange={onChangeProductSelect}
                radioName='product_select_group'
              />
            ))}
          </ul>
        </form>

        <BaseButton label='Voltar' onClick={buttonHandler} />
      </main>
    </>
  );
};

export default ProductSelect;
