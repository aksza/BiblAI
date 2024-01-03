import React from 'react';
import {Link} from 'react-router-dom';
import '../styles/header.css';
import { useState, useEffect } from 'react';
import { useUser } from '../services/userContext';

interface HeaderProps {
  setSearchTerm: (searchTerm: string) => void;
}

export const Header = ({setSearchTerm}: HeaderProps) => {
  const user = useUser();

  const [token, setToken] = useState<string | null>(null);
  const deleteToken = () => {
    localStorage.removeItem('token')
    setToken(null)
    console.log('token deleted')
    window.location.href = '/login';
    // Delete information from local storage
    localStorage.removeItem('userId');
    localStorage.removeItem('userName');
    localStorage.removeItem('profilePictureUrl');
  }

  useEffect(() => {
    const storedToken = localStorage.getItem('token');
    if (storedToken) {
      setToken(storedToken);
    }
  }, []);

  return (
    <div className='Header'>
      <Link to={`/home`}><img id='home_icon' src="https://scontent.xx.fbcdn.net/v/t1.15752-9/411609070_380278494466846_7015368164111501922_n.png?_nc_cat=106&ccb=1-7&_nc_sid=510075&_nc_ohc=TLdBL3dtF_MAX8twcAb&_nc_oc=AQl0czhTvZ197xOmW5QkPL5-3MS6CX0XSjZ1Kv7WTsk8OAqnOEk3tNSZ_U7N3WQ7GOtS6tuojLqIWJpD6I7F8nhO&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=03_AdQvlgJz1e8tJZkaXbwBCLWd5Ullv76eVTGxzKgcVljBKw&oe=65A7B1A8" alt="" /></Link>
      <input className='search_bar' type="text" placeholder="Search" onChange={(e) => setSearchTerm(e.target.value)} />
      <div>
        {!token ?
        <div className='header_right_side'>
        <Link to='/question'><i className="fi fi-br-plus"></i></Link>
        <Link to='/login'><i className="fi fi-rr-sign-in-alt"></i></Link>
        </div>
        : 
        <div className='header_right_side'>
        <Link to='/question'><i className="fi fi-br-plus"></i></Link>
        <i className="fi fi-rs-exit" onClick={deleteToken}></i>
        <Link to={`profile/${localStorage.getItem('userId') ?? ''}`}><img src={localStorage.getItem('profilePictureUrl') ?? ''} alt='' /></Link>
        </div>
        }
      </div>
    </div>
  );
};
