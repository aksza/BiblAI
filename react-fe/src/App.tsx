import React from 'react';
import {BrowserRouter as Router, Route, Routes, Link} from 'react-router-dom';
import { QueryClient, QueryClientProvider } from "react-query"
import {Home} from './pages/Home';
import {Profile} from './pages/Profile';
import {Header} from './components/Header';
import '../src/styles/app.css';
import { Login } from './pages/Login';
import { Register } from './pages/Register';
import { Question } from './pages/Question';
import { Answer } from './pages/Answer';
import { UserProvider } from './services/userContext';
import '../src/styles/background.css';

function App() {


  const client = new QueryClient({
    defaultOptions: {
      queries: {
        refetchOnWindowFocus: false
      }
    }
  });

  return (
    <div className="App">
      <div className='background'></div>
      <UserProvider>
      <QueryClientProvider client={client}>
        <Router>
          <Header />
          <Routes>
            <Route path="/home" element={<Home />} />
            <Route path="/profile/:userId" element={<Profile />} />
            <Route path="/login" element={<Login />} />
            <Route path="/register" element={<Register />} />
            <Route path="/question" element={<Question />} /> 
            <Route path="/answer" element={<Answer />} />
          </Routes>
        </Router>
      </QueryClientProvider>
      </UserProvider>
    </div>
  );
}

export default App;
