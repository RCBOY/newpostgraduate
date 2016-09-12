package DAO;

import Util.HibernateUtil;
import com.model.Student;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.io.Serializable;
import java.util.List;

/**
 * Created by 1234ztc on 2016/5/24.
 */
public class BaseDAO<T> {
    public void add(T object) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            Transaction transaction = session.beginTransaction();
            session.persist(object);
            transaction.commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
    }

    public void update(T object) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            Transaction transaction = session.beginTransaction();
            session.update(object);
            transaction.commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
    }

    public void delete(T object) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            Transaction transaction = session.beginTransaction();
            session.delete(object);
            transaction.commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
    }

    @SuppressWarnings("unchecked")
    public T find(Class<? extends T> clazz, Serializable id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.beginTransaction();
            return (T) session.get(clazz, id);
        } finally {
            session.getTransaction().commit();
            session.close();
        }
    }

    public T findByNum(Class<? extends T> clazz, String num) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.beginTransaction();
            return (T) session.createQuery("from" + clazz + "u where u.snum=" + num).list();
        } finally {
            session.getTransaction().commit();
            session.close();
        }
    }

    @SuppressWarnings("unchecked")
    public List<T> list(String hql) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.beginTransaction();
            return session.createQuery(hql).list();
        } finally {
            session.getTransaction().commit();
            session.close();
        }
    }
    public List<T> list(String hql,int offset,int pagesize) {
        Session session= HibernateUtil.getSessionFactory().openSession();
        List list=null;
        try {
            session.beginTransaction();
            Query query=session.createQuery(hql);
            if (offset != 0 && pagesize != 0) {
                query.setFirstResult((offset - 1) * pagesize);
                query.setMaxResults(pagesize);
            }
            return list=query.list();
        }
        finally {
            session.getTransaction().commit();
            session.close();
        }
    }
    public List<T> list(String hql,int lenth) {
        Session session= HibernateUtil.getSessionFactory().openSession();
        List list=null;
        try {
            session.beginTransaction();
            Query query=session.createQuery(hql);

                query.setFirstResult((0));
                query.setMaxResults(lenth);
            return list=query.list();
        }
        finally {
            session.getTransaction().commit();
            session.close();
        }
    }
    public Number findNum(Class<? extends T> clazz){
        Session session= HibernateUtil.getSessionFactory().openSession();
        try {
            String hql="select count(i) from "+clazz+" i";
            session.beginTransaction();
            return (Number) session.createQuery(hql).uniqueResult();
        } finally {
            session.getTransaction().commit();
            session.close();
        }
    }

}

