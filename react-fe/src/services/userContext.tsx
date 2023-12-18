// UserContext.tsx
import React, { createContext, useContext, useState, ReactNode } from 'react';

// Define the User type
export interface User {
  id: number | null;
  userName: string;
  profilePictureUrl: string;
}

// Define the Context type
interface UserContextType {
  user: User;
  updateUser: (newUserData: Partial<User>) => void;
}

// Create the Context
const UserContext = createContext<UserContextType | undefined>(undefined);

// Define the UserProvider props
interface UserProviderProps {
  children: ReactNode;
}

export const UserProvider: React.FC<UserProviderProps> = ({ children }) => {
  const [user, setUser] = useState<User>({
    id: null,
    userName: '',
    profilePictureUrl: '',
  });

  const updateUser = (newUserData: Partial<User>) => {
    setUser((prevUser) => ({ ...prevUser, ...newUserData }));
  };

  // Use ! to assert that the context value will always be defined
  const value: UserContextType = { user, updateUser };

  return <UserContext.Provider value={value}>{children}</UserContext.Provider>;
};

export const useUser = (): UserContextType => {
  const context = useContext(UserContext);
  if (!context) {
    throw new Error('useUser must be used within a UserProvider');
  }
  return context;
};
