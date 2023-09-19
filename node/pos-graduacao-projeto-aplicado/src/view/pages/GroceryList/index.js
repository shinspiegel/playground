import React, { useState, useEffect } from 'react';
import { MdPersonOutline, MdAddShoppingCart, MdSettingsBackupRestore } from 'react-icons/md';
import { motion } from 'framer-motion';
import swal from 'sweetalert';
import './index.css';

import { useParams, useHistory } from 'react-router-dom';
import useActions from '../../context/useActions';
import { findGroceryList, changeWeek, getWeekNumber } from '../../utils';

import Navigation from '../../components/Navigation';
import ProductsList from '../../components/ProductsList';
import ProductItem from '../../components/ProductItem';
import ProductItemNew from '../../components/ProductItemNew';
import BottomMenu from '../../components/BottomMenu';
import BottomMenuItem from '../../components/BottomMenuItem';
import Loader from '../../components/Loader';

const GroceryList = () => {
  const { push } = useHistory();
  const { year, week } = useParams();
  const { state, getList, updateList, getFromLastWeek } = useActions();
  const { groceryList, isLoading } = state;
  const [totalPrice, setTotalPrice] = useState(0);

  useEffect(() => {
    getList({ year, week });

    return () => {};
  }, [year, week]);

  const findedList = findGroceryList(groceryList, year, week);

  useEffect(() => {
    updateTotalPrice();
  }, [findedList]);

  const onBlurHandler = ({ product, index }) => {
    const newList = [...findedList.productsList];
    newList[index] = product;

    updateList({ updatedList: newList, listId: findedList._id, year, week });
  };

  const removeProduct = (productIndex) => {
    const newList = findedList.productsList.filter((_, index) => index !== productIndex);

    updateList({ updatedList: newList, listId: findedList._id, year, week });
  };

  const onClickNewProduct = (newProduct) => {
    const newList = [...findedList.productsList];
    newList.push({ productName: newProduct });

    updateList({ updatedList: newList, listId: findedList._id, year, week });
  };

  const onClickGetFromLastWeek = () => {
    swal(
      'Esta opção irá passar todos os produtos não comprados da semana anterior para esta semana, deseja confirmar esta ação?',
      { buttons: { cancel: 'Cancelar', confirm: 'Confirmar' } },
    ).then((ok) => {
      if (ok) getFromLastWeek(year, week);
    });
  };

  const onClickSearchProduct = (productId) => {
    if (!productId) return;

    push(`/product-select/${year}/${week}/${productId}`);
  };

  const onClickBuyToggle = (productId) => {
    const newList = [...findedList.productsList];
    const index = newList.findIndex((product) => product._id === productId);
    newList[index].isBought = !newList[index].isBought;

    updateList({ updatedList: newList, listId: findedList._id, year, week });
    updateTotalPrice();
  };

  const updateTotalPrice = () => {
    if (!findedList) return;

    let price = 0;

    findedList.productsList.map((product) => {
      if (!product.isBought && product.productReference) {
        price += product.productReference.price;
      }
    });

    setTotalPrice(price);
  };

  const handleNavigation = (weekChange) => {
    const { year: newYear, week: newWeek } = changeWeek({ weekChange, year, week });
    push(`/list/${newYear}/${newWeek}`);
  };

  const handleCurrentWeek = () => {
    const newYear = new Date().getFullYear();
    const newWeek = getWeekNumber();

    if (newYear !== year || newWeek !== week) {
      push(`/list/${newYear}/${newWeek}`);
    }
  };

  return (
    <>
      <Navigation
        weekNumber={week}
        price={totalPrice}
        onClickNext={() => handleNavigation(1)}
        onClickPrev={() => handleNavigation(-1)}
      />

      <motion.main initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }} className="groceryList">
        {findedList ? (
          <ProductsList>
            {findedList.productsList.map((product, index) => (
              <ProductItem
                key={product._id + index}
                product={product}
                productIndex={index}
                onBlur={onBlurHandler}
                removeProdut={() => removeProduct(index)}
                searchIcon={() => onClickSearchProduct(product._id)}
                toggleIcon={() => onClickBuyToggle(product._id)}
              />
            ))}
            <ProductItemNew onClick={onClickNewProduct} placeholder="Preciso comprar..." />
          </ProductsList>
        ) : null}
        <Loader isLoading={isLoading} />
      </motion.main>

      <BottomMenu>
        <BottomMenuItem onClick={() => push('/profile')} icon={MdPersonOutline} label="Perfil do usuário" />
        <BottomMenuItem onClick={onClickGetFromLastWeek} icon={MdAddShoppingCart} label="Resgatar semana" />
        <BottomMenuItem onClick={handleCurrentWeek} icon={MdSettingsBackupRestore} label="Semana Atual" />
      </BottomMenu>
    </>
  );
};

export default GroceryList;
