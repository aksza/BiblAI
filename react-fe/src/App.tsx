import React from 'react';
import {BrowserRouter as Router, Route, Routes, Link} from 'react-router-dom';
import { QueryClient, QueryClientProvider } from "react-query"
import {Home} from './pages/Home';
import {Profile} from './pages/Profile';
import {Header} from './components/Header';
import '../src/styles/app.css';
import Login from './pages/Login';

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
      <QueryClientProvider client={client}>
        <Router>
          <Header />
          <Routes>
            <Route path="/home" element={<Home />} />
            <Route path="/profile/:userId" element={<Profile />} />
            <Route path="/login" element={<Login />} />
          </Routes>
        </Router>
      </QueryClientProvider>
    </div>
  );
}

export default App;
